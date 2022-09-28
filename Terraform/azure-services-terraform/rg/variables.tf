variable "location" {
  description = "Azure region to use"
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

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment_number" {
  description = "Client name/account used in naming"
  type        = string
}

variable "rg_number" {
  description = "RG number"
  type = number
}

variable "subscription_prefix" {
  description = "Subscription prefix"
  type = string
}

variable "owners" {
  description = "Project owners"
  type        = list(string)
}

variable "environment_category" {
  description = "Project environment category"
  type        = string
}

variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "custom_rg_name" {
  description = "Optional custom resource group name"
  type        = string
  default     = ""
}

variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
}

variable "lock_level" {
  description = "Specifies the Level to be used for this RG Lock. Possible values are Empty (no lock), CanNotDelete and ReadOnly."
  type        = string
  default     = ""
}
