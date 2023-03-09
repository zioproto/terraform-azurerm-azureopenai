# Azure provider version 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {
  features {}
}

# Private DNS Zone for SQL API in both vnets
resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_link_one" {
  name                  = "dns_zone_link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = module.vnet.vnet_id
  registration_enabled  = false
}


module "openai" {
  source              = "git::https://github.com/soferreira/terraform-azurerm-azureopenai.git"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  name                = "openai-account-tf"
  private_endpoint = {
    "pe_endpoint" = {
      enable_private_dns_entry        = true
      dns_zone_group_name             = "pe_one_zone_group"
      dns_zone_rg_name                = azurerm_private_dns_zone.dns_zone.resource_group_name
      is_manual_connection            = false
      name                            = "pe_one"
      private_service_connection_name = "pe_one_connection"
      subnet_name                     = "subnet0"
      vnet_name                       = module.vnet.vnet_name
      vnet_rg_name                    = azurerm_resource_group.this.name
    }
  }
  depends_on = [
    azurerm_resource_group.this,
    azurerm_private_dns_zone.dns_zone,
  ]
}
