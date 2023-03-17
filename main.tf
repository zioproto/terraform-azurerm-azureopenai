resource "random_integer" "this" {
  min = 100000
  max = 999999
}

locals {
  azureopenai_account_name         = coalesce(var.azureopenai_account_name, "azureopenai-${random_integer.this.result}")
  azureopenai_customsubdomain_name = coalesce(var.azureopenai_customsubdomain_name, "azureopenai-${random_integer.this.result}")
}

resource "azurerm_cognitive_account" "this" {
  kind                          = "OpenAI"
  location                      = local.location
  name                          = local.azureopenai_account_name
  resource_group_name           = data.azurerm_resource_group.this.name
  sku_name                      = var.sku_name
  custom_subdomain_name         = local.azureopenai_customsubdomain_name
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags
}