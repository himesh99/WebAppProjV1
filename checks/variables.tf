variable "subscription_id" {
  type    = string
}
variable "tenant_id" {
  type        = string
  description = "Defines the tenant id"
}
variable "environment" {
  type    = string
  }

variable "resource_group_hp" {
  type        = string
  description = "Resource Group to deploy resources into."
}