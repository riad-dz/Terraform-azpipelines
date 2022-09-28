resource "azurerm_container_registry" "main" {
  name                    = "${var.prefix}${title(var.environment)}"
  resource_group_name     = var.resource
  location                = var.location
  sku                     = var.sku
  admin_enabled           = true

  tags = {
    Creation_Date         = var.date
  }
  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}
