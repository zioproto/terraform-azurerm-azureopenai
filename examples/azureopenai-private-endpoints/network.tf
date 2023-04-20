resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_link" {
  name                  = "dns_zone_link"
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_id    = module.vnet.vnet_id
  registration_enabled  = false
}

resource "azurerm_private_dns_a_record" "openai" {
  name                = module.openai.openai_subdomain
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300
  records             = [module.openai.private_ip_address]
}

module "vnet" {
  source  = "Azure/subnets/azurerm"
  version = "1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  subnets = {
    subnet0 = {
      address_prefixes  = ["10.52.0.0/16"]
      service_endpoints = ["Microsoft.CognitiveServices"]
    }
  }
  virtual_network_address_space = ["10.52.0.0/16"]
  virtual_network_location      = "westeurope"
  virtual_network_name          = "vnet"
}
