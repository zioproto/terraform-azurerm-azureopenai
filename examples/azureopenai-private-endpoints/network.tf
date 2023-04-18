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

resource "azurerm_private_dns_a_record" "example" {  
  name                = "example-a-record"  
  zone_name           = azurerm_private_dns_zone.dns_zone.name  
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300  
  records             = ["10.52.0.5"]  # remove hardcoded value
}  
  
resource "azurerm_private_dns_cname_record" "example" {  
  name                = "example-cname-record"  
  zone_name           = azurerm_private_dns_zone.dns_zone.name  
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300  
  record              = replace(replace(module.openai.openai_endpoint, "https://", ""), "/", "")
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