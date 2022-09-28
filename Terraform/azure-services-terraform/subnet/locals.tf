locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = lower("${substr(var.project, 0, 3)}${var.environment_number}${var.location_short}-vnet${format("%02d", var.vnet_number)}-snet${format("%02d", var.snet_number)}-${var.subscription_prefix}")

  subnet_name = coalesce(var.custom_subnet_name, local.default_name)

  subnets_outputs = zipmap(azurerm_subnet.subnet[*].name, azurerm_subnet.subnet[*].id)

  network_security_group_rg = coalesce(var.network_security_group_rg, var.resource_group_name)
  route_table_rg            = coalesce(var.route_table_rg, var.resource_group_name)

  network_security_group_id = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/networkSecurityGroups/%s", data.azurerm_subscription.current.subscription_id, local.network_security_group_rg, coalesce(var.network_security_group_name, "fake"))

  route_table_id = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/routeTables/%s", data.azurerm_subscription.current.subscription_id, local.route_table_rg, coalesce(var.route_table_name, "fake"))
}
