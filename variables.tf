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

variable "default_tags_enabled" {
  type        = bool
  description = "Determines whether or not default tags are applied to resources. If set to true, tags will be applied. If set to false, tags will not be applied."
  default     = false
  nullable    = false
}

variable "deployment" {
  type = map(object({
    name            = string
    model_format    = string
    model_name      = string
    model_version   = string
    scale_type      = string
    rai_policy_name = optional(string)
  }))
  default     = {}
  nullable    = false
  description = <<DESCRIPTION
      deployment = {
        name                 = "(Required) The name of the Cognitive Services Account Deployment. Changing this forces a new resource to be created."
        cognitive_account_id = "(Required) The ID of the Cognitive Services Account. Changing this forces a new resource to be created."
        model = {
          model_format  = "(Required) The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI."
          model_name    = "(Required) The name of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created."
          model_version = "(Required) The version of Cognitive Services Account Deployment model."
        }
        scale = {
          scale_type = "(Required) Deployment scale type. Possible value is Standard. Changing this forces a new resource to be created."
        }
        rai_policy_name = "(Optional) The name of RAI policy. Changing this forces a new resource to be created."
      }
  DESCRIPTION
}

variable "environment" {
  type        = string
  description = "Environment of the application."
  default     = ""
}

variable "network_acls" {
  type = object({
    default_action = string
    ip_rules       = list(string)
    virtual_network_rules = object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = bool
    })
  })
  description = "An object that represents the configuration for a network ACL."
  default     = null
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
  description = "A map of objects that represent the configuration for a private endpoint."
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
