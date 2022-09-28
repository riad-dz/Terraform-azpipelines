# Global variables
variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment_number" {
  description = "Client name/account used in naming"
  type        = string
}

variable "rt_number" {
  description = "RT number"
  type = number
}

variable "subscription_prefix" {
  description = "Subscription prefix"
  type = string
}

variable "environment_category" {
  description = "Project environment category"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "name_prefix" {
  description = "Optional prefix for VPN Gateway name"
  type        = string
  default     = ""
}

variable "custom_name" {
  description = "Custom Route table name, generated if not set"
  default     = ""
  type        = string
}

variable "extra_tags" {
  description = "Additional tags to associate with your resources."
  type        = map(string)
  default     = {}
}

variable "disable_bgp_route_propagation" {
  description = "Option to disable BGP route propagation on this Route Table."
  type        = bool
  default     = false
}

variable "enable_force_tunneling" {
  description = "Option to enable a route to Force Tunneling (force 0.0.0.0/0 traffic through the Gateway next hop)."
  type        = bool
  default     = false
}
