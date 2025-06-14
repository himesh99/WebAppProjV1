variable "resource_group_hp" {
  type        = string
  default     = "himesh-patel-sandbox-rg"
  description = "Resource Group to deploy resources into."
}

variable "tfversion" {
  type        = string
  default     = "1.3.7"
  description = "Defines the terraofrm version"
}

variable "workingDirectory" {
  type        = string
  default     = "./"
  description = "States the root working directory"
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "Defines the location"
}

variable "az-subscription-id" {
  description = "The subscription ID"
  type        = string
  validation {
    condition     = length(var.az-subscription-id) > 0
    error_message = "The subscription ID must not be empty"
  }
}

variable "tags" {
  type        = map(string)
  description = "Defines the tags"
  default = {
    Application-criticality = "low"
    Application-name        = "DDC Sandboxes"
    Business-unit           = "Azure Team Eagle"
    Business-unit-sponsor   = "DDC"
    Cost-centre             = "DDC"
    Data-classification     = "TBC"
    Environment-type        = "sandbox"
    Project                 = "Azure Team Eagle"

  }
}

variable "secrets" {
  type = list(object({
    name         = string
    value        = string
    tags         = map(string)
    content_type = string
  }))
  description = "Define Azure Key Vault secrets"
  default     = []
}

variable "environment" {
  type = string
}

variable "tenant_id" {
  type    = string
  default = "abcdef"

}

variable "object_id" {
  type    = string
  default = "abcdef"

}

variable "v1_object_id" {
  type    = string
  default = "abcdef"

}

variable "wordpress_image" {
  type        = string
  description = "Docker repository name with tag, e.g. Defaults to onazureio/wordpress:5.5"
  default     = "wordpress:latest"
}

variable "address_space" {
  type        = string
  description = "(Required) VNET and subnet address space"
  # from <env.tfvars>

  validation {
    condition     = can(cidrhost(var.address_space, 0))
    error_message = "Must be valid IPv4 cidr"
  }
}

variable "address_space_snet_int" {
  type        = string
  description = "(Required) db subnet address space"

  validation {
    condition     = can(cidrhost(var.address_space_snet_int, 0))
    error_message = "Must be valid IPv4 cidr"
  }
}

variable "address_space_snet_pe" {
  type        = string
  description = "(Required) services subnet address space"

  validation {
    condition     = can(cidrhost(var.address_space_snet_pe, 0))
    error_message = "Must be valid IPv4 cidr"
  }
}