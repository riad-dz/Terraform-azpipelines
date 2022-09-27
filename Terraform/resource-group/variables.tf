variable "location_rg" {
  description = "Azure region to use"
  type        = string
  default= "#{location_rg}#"

}

variable "environment" {
  description = "Project environment"
  type        = string
  default= "#{environment}#"

}

variable "rg_name" {
  description = "RG number"
  type = string
  default= "#{rg_name}#"

}

variable "az_subscription" {
  description = "ID for Azure Subscription "
  type = string
  default="#{az_subscription}#"

}

variable "owner" {
  description = "Project owner"
  type        = string
  default= "#{owner}#"

}

variable "lock_level" {
  description = "Specifies the Level to be used for this RG Lock. Possible values are Empty (no lock), CanNotDelete and ReadOnly."
  type        = string
  default= "#{lock_level}#"
}

variable "subscription_id" {
  description = "Specifies the ID of Azure Subscription"
  type        = string
  default= "#{subscription_id}#"

}

variable "tenant_id" {
  description = "Specifies the ID of Azure Subscription"
  type        = string
  default= "#{tenant_id}#"

}

variable "client_id" {
  description = "Specifies the ID of Azure Subscription"
  type        = string
  default= "#{client_id}#"

}

variable "client_secret" {
  description = "Specifies the ID of Azure Subscription"
  type        = string
  default= "#{client_secret}#"

}

variable "rg_backend_name" {
  description = "Specifies the rg_backend_name"
  type        = string
  default= "#{rg_backend_name}#"

}

variable "storage_account_backend" {
  description = "Specifies the storage_account_backend"
  type        = string
  default= "#{storage_account_backend}#"

}

variable "container_tfsate" {
  description = "Specifies the container_tfsate"
  type        = string
  default= "#{container_tfstate}#"

}

variable "key_tfstate" {
  description = "Specifies the key_tfstate"
  type        = string
  default= "#{key_tfstate}#"
}

variable "application_name" {
  description = "Specifies the app name"
  type        = string
  default= "#{application_name}#"
}