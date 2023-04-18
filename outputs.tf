# Just for testing
output "openai_endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "openai_key" {
  description = "The primary access key for the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.primary_access_key
}

output "private_endpoint_ids" {  
  value = {  
    for key, pe in azurerm_private_endpoint.this : key => pe.id  
  }  
  description = "A map of private endpoint IDs with their respective keys."  
}  
