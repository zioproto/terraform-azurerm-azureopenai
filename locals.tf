resource "random_integer" "this" {
  min = 100000
  max = 999999
}


locals {
  tags = {
    Application_Name = "var.application_name"
    Environment      = "var.environment"
  }
  azureopenai_account_name = var.azureopenai_account_name != "" ? var.azureopenai_account_name : "azopenai-${random_integer.this.result}"
  azureopenai_custom_subdomain_name = var.azureopenai_custom_subdomain_name != "" ? var.azureopenai_custom_subdomain_name : "azopenai-${random_integer.this.result}"
  location                 = var.location != "" ? var.location : data.azurerm_resource_group.this.location
}