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

resource "azurerm_cognitive_account" "this" {
  name                          = local.azureopenai_account_name
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.this.name
  kind                          = "OpenAI"
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags
  custom_subdomain_name         = local.azureopenai_customsubdomain_name
}

# Just for testing
output "openai_endpoint" {
  value = azurerm_cognitive_account.this.endpoint
}

output "openai_key" {
  value = azurerm_cognitive_account.this.primary_access_key
}
