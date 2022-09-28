resource "azurerm_servicebus_queue" "queue" {
  name                = var.name
  resource_group_name = var.resource
  namespace_name      = var.namespace

  enable_partitioning = false
}

resource "azurerm_servicebus_queue_authorization_rule" "queue_rule" {
  name                = var.name
  resource_group_name = var.resource
  namespace_name      = var.namespace
  queue_name          = azurerm_servicebus_queue.queue.name

  listen = true
  send   = true
  manage = false
}
