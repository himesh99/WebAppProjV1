variable "resource_group_hp" {
  type = string
  default = "patelh-sandbox-rg"
  description = "Resource Group to deploy resources into."
}
variable "tfversion" {
  type = string
  default = "1.3.7"
}
variable "workingDirectory" {
  type = string
  default = "./"
}
variable "location" {
  type = string
  default = "uksouth"
}
variable "subscription_id" {
  type = string
  default = "4ac7e4ba-2b33-4c38-8852-1a6ba4098aa3"
}
variable "tenant_id" {
  type = string
  default = "3e0088dc-0629-4ae6-aa8c-813e7a296f50"
}
variable "tags" {
  type = map(string)
  default = {
    Application-criticality = "low"
    Application-name = "DDC Sandboxes"
    Business-unit = "Azure Team Eagle"
    Business-unit-sponsor = "DDC"
    Cost-centre = "DDC"
    Data-classification = "TBC"
    Deployment-date = "2024-09-07 15:04 UTC"
    Environment-type = "sandbox"

  }
}