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
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type        = string
  description = "Defines the tenant id"
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
    Deployment-date         = "2024-09-07 15:04 UTC"
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

variable "object_id" {
  type        = string
  description = "Defines the service principal id"
}

variable "sa_access_key" {
  type = string
}

variable "environment" {
  type = string
}

