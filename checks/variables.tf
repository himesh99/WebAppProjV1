variable "environment" {
  type    = string
  default = "dev"
}

variable "resource_group_hp" {
  type        = string
  description = "Resource Group to deploy resources into."
  default     = "himesh-patel-sandbox-rg"
}