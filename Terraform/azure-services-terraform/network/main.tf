resource "azurerm_virtual_network" "main" {
  name                    = "${var.prefix}${title(var.environment)}"
  location                = var.location
  resource_group_name     = var.resource
  address_space           = ["10.1.0.0/16"]

  tags = {
    Creation_Date         = var.date
  }
  lifecycle {
    ignore_changes        = [
      tags,
    ]
  }
}

resource "azurerm_subnet" "internal" {
  name                    = "${var.prefix}${title(var.environment)}Internal"
  virtual_network_name    = azurerm_virtual_network.main.name
  resource_group_name     = var.resource
  address_prefixes        = ["10.1.0.0/22"]
}