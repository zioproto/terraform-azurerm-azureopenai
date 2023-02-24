variable "resource_group_name" {
  type        = string
  description = "Name of the azure resource group."
}

variable "location" {
  type        = string
  description = "Azure OpenAI deployment region."
  default     = ""
}

variable "azureopenai_account_name" {
  type        = string
  description = "Name of the Cosmos DB account."
  default     = ""
}

variable "sku_name" {
  type        = string
  description = "Azure OpenAI account SKU name."
  default     = "S0"
}

variable "custom_subdomain_name" {
  type        = string
  description = "Azure OpenAI account custom subdomain name."
  default     = ""
}

variable "network_acls_default_action" {
  type        = string
  description = "Azure OpenAI account network ACLs default action."
  default     = "Deny"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Azure OpenAI account public network access enabled."
  default     = false

}