variable "location" {
  type        = string
  description = "Azure OpenAI deployment region. Set this variable to `null` would use resource group's location."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the azure resource group to use. The resource group must exist."
}

variable "application_name" {
  type        = string
  description = "Name of the application."
  default     = ""
}

variable "azureopenai_account_name" {
  type        = string
  description = "Name of the OpenAI account."
  default     = ""
}

variable "azureopenai_customsubdomain_name" {
  type        = string
  description = "Name of the OpenAI account custom subdomain."
  default     = ""
}

variable "deployment" {
  type = map(object({
    name          = string
    model_format  = string
    model_name    = string
    model_version = string
    scale_type    = string
  }))
  description = "Parameters for deployment creation"
  default     = {}
  nullable    = false
}

variable "azureopenai_deployment_name" {
  type        = string
  description = "OpenAI model deployments."
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment of the application."
  default     = ""
}

# tflint-ignore: terraform_unused_declarations
variable "network_acls_default_action" {
  type        = string
  description = "Azure OpenAI account network ACLs default action."
  default     = "Deny"
}

variable "pe_subresource" {
  type        = string
  description = "Map of subresources to choose appropriate Private Endpoint sub resource"
  default     = "account"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Map of the private DNS zone to choose approrite Private DNS Zone"
  default     = "privatelink.openai.azure.com"
}

variable "private_endpoint" {
  type = map(object({
    name                            = string
    vnet_rg_name                    = string
    vnet_name                       = string
    subnet_name                     = string
    dns_zone_rg_name                = optional(string, "default")
    private_dns_entry_enabled       = optional(bool, false)
    dns_zone_group_name             = string
    private_service_connection_name = optional(string, "privateserviceconnection")
    is_manual_connection            = optional(bool, false)
  }))
  description = "Parameters for private endpoint creation"
  default     = {}
  nullable    = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Azure OpenAI account public network access enabled."
  default     = false
}

variable "sku_name" {
  type        = string
  description = "Azure OpenAI account SKU name."
  default     = "S0"
}