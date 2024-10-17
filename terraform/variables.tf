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
  type    = string
  default = "4ac7e4ba-2b33-4c38-8852-1a6ba4098aa3"
}
variable "tenant_id" {
  type        = string
  default     = "3e0088dc-0629-4ae6-aa8c-813e7a296f50"
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
  default     = "18755058-a4c0-4705-b50a-35348fb876d6"
  description = "Defines the service principal id"
}

variable "sa_access_key" {
  type    = string
  default = "X/oxLevITii1fcgdxp1oRq+0ujmHELv0dFcOR9k2Pfe8qPEBn8fAm/JQvYpeEIOmEpiTlAdpw4dx+AStoZSU+w=="
}

variable "environment" {
  type    = string
  }
