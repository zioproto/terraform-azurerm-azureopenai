resource "random_integer" "this" {
  min = 100000
  max = 999999
}

resource "azurerm_resource_group" "this" {
  location = "eastus"
  name     = "rg-openai-tf-${random_integer.this.result}"
}