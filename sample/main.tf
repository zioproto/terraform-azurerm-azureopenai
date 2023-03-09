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


module "openai" {
  source              = "git::https://github.com/soferreira/terraform-azurerm-azureopenai.git"
  resource_group_name = azurerm_resource_group.this.name
}
