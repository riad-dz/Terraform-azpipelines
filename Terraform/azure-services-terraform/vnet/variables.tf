variable "location" {
  description = "Azure region to use"
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

variable "vnet_number" {
  description = "RG number"
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

variable "name_prefix" {
  description = "Optional prefix for vnet names"
  type        = string
  default     = ""
}

variable "custom_vnet_name" {
  description = "Optional custom virtual network name"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_cidr" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers"
  type        = list(string)
  default     = []
}

variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
}
