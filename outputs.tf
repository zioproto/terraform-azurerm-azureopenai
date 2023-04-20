# Just for testing
output "openai_endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "openai_subdomain" {
  description = "The subdomain used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.custom_subdomain_name
}

output "private_ip_address" {
  description = "TODO: FIX THIS OUTPUT, THIS IS JUST A TEST"
  value = azurerm_private_endpoint.this["pe_endpoint"].private_service_connection[0].private_ip_address
}

output "openai_key" {
  description = "The primary access key for the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.primary_access_key
}
