variable "environment" {
  type    = string
  default = "development"
}

variable "resource_group_hp" {
  type        = string
  description = "Resource Group to deploy resources into."
  default     = "patelh-sandbox-rg"
}