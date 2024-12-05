variable "resource_group_hp" {
  type        = string
  default     = "patelh-sandbox-rg"
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







variable "object_id" {
  type        = string
  description = "V1 objectID"
  default     = "0e4b967e-0513-4269-aa22-687166d31276"
}
