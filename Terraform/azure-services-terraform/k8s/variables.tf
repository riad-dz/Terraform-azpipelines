variable "location" {
    description     = "Azure Location for Resources"
    type            = string
}

variable "prefix" {
    description     = "Prefix Used for Resources"
    type            = string
}

variable "resource" {
    description     = "Azure Resource Name"
    type            = string
}

variable "environment" {
    description     = "Environment Name"
    type            = string
}

variable "subnet_id" {
    description     = "Environment Name"
    type            = string
}

variable "date" {
    description     = "Date to add as tag creation date"
    type            = string
}