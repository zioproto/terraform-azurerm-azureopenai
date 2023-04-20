module "openai" {
  source              = "../.."
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  private_endpoint = {
    "pe_endpoint" = {
      enable_private_dns_entry        = true
      dns_zone_group_name             = azurerm_private_dns_zone.dns_zone.name
      dns_zone_rg_name                = azurerm_private_dns_zone.dns_zone.resource_group_name
      is_manual_connection            = false
      name                            = "pe_one"
      private_service_connection_name = "pe_one_connection"
      subnet_name                     = "subnet0"
      vnet_name                       = module.vnet.vnet_name
      vnet_rg_name                    = azurerm_resource_group.this.name
    }
  }
  deployment = {
    "text-curie-001" = {
      name          = "text-curie-001"
      model_format  = "OpenAI"
      model_name    = "text-curie-001"
      model_version = "1"
      scale_type    = "Standard"
    },
    "text-search-curie-query-001" = {
      name          = "text-search-curie-query-001"
      model_format  = "OpenAI"
      model_name    = "text-search-curie-query-001"
      model_version = "1"
      scale_type    = "Standard"
    },
  }
  depends_on = [
    azurerm_resource_group.this,
    azurerm_private_dns_zone.dns_zone,
    module.vnet,
  ]
}
