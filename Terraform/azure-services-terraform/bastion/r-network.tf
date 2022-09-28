resource "azurerm_public_ip" "public_ip" {
  name                = coalesce(var.custom_public_ip_name, local.public_ip_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.public_ip_sku

  tags = merge(local.default_tags, var.extra_tags, var.public_ip_extra_tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}