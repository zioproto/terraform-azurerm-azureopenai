# Just for testing
output "openai_endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "openai_key" {
  description = "The primary access key for the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.primary_access_key
}
