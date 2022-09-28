output "name" {
  value = azurerm_servicebus_queue.queue.name
}

output "key" {
  value = azurerm_servicebus_queue_authorization_rule.queue_rule.primary_key
}

output "connection_string" {
  value = azurerm_servicebus_queue_authorization_rule.queue_rule.primary_connection_string
}
