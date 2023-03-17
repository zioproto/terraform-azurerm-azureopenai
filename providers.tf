# Azure provider version
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

