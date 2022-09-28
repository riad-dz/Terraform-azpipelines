variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
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
  description = "Optional prefix for Network Security Group name"
  type        = string
  default     = ""
}

variable "custom_network_security_group_name" {
  description = "Security Group custom name."
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Additional tags to associate with your Network Security Group."
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment_number" {
  description = "Client name/account used in naming"
  type        = string
}

variable "nsg_number" {
  description = "nsg number"
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