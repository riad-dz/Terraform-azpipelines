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

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment_number" {
  description = "Client name/account used in naming"
  type        = string
}

variable "vm_number" {
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

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Id of the Subnet in which create the Virtual Machine"
  type        = string
}

### Network inputs
variable "custom_public_ip_name" {
  description = "Custom name for public IP. Should be suffixed by \"-pubip\". Generated if not set."
  type        = string
  default     = null
}

variable "custom_name" {
  description = "Custom name for the Virtual Machine. Should be suffixed by \"-vm\". Generated if not set."
  type        = string
  default     = ""
}

variable "extra_tags" {
  description = "Extra tags to set on each created resource."
  type        = map(string)
  default     = {}
}

variable "public_ip_extra_tags" {
  description = "Extra tags to set on the public IP resource."
  type        = map(string)
  default     = {}
}

variable "public_ip_sku" {
  description = "Sku for the public IP attached to the VM. Can be `null` if no public IP needed."
  type        = string
  default     = "Standard"
}