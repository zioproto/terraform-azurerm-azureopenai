resource "random_integer" "this" {
  min = 100000
  max = 999999
}

locals {
  azureopenai_account_name         = coalesce(var.azureopenai_account_name, "azureopenaii-${random_integer.this.result}")
  azureopenai_customsubdomain_name = coalesce(var.azureopenai_customsubdomain_name, "azureopenaii-${random_integer.this.result}")
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = data.azurerm_resource_group.this.name
  location            = local.location
  name                = "user_assigned_identity"
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
  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}
