resource "azurerm_route_table" "route-table" {
  name                = local.rt_name
  location            = var.location
  resource_group_name = var.resource_group_name

  disable_bgp_route_propagation = var.disable_bgp_route_propagation

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_route" "force-internet-tunneling" {
  name                = "InternetForceTunneling"
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.route-table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "VirtualNetworkGateway"

  count = var.enable_force_tunneling ? 1 : 0
}

