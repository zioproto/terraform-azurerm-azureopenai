module "vnet" {
  source              = "git::https://github.com/lonegunmanb/terraform-azurerm-subnets.git"
  resource_group_name = azurerm_resource_group.this.name
  subnets = {
    subnet0 = {
      address_prefixes = ["10.52.0.0/16"]
    }
  }
  virtual_network_address_space = ["10.52.0.0/16"]
  virtual_network_location      = "westeurope"
  virtual_network_name          = "vnet"
}

# Private DNS Zone for SQL API in both vnets
resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_link" {
  name                  = "dns_zone_link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = module.vnet.vnet_id
  registration_enabled  = false
}
