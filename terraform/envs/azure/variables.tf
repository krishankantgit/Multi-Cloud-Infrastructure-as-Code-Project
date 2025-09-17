variable "location" {
  type        = string
  description = "Azure location"
  default     = "eastus"
}

variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources"
  default     = "mc"
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR block"
  default     = "10.30.0.0/16"
}


