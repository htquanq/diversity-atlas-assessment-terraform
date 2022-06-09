variable "tags" {
  default = {}
}

variable "cidr_block" {
  type    = string
  default = null
}

variable "instance_tenancy" {
  type    = string
  default = "default"
  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "Instance tenancy for VPC, please check again. Valid values are: default or dedicated."
  }
}

variable "ipv4_ipam_pool_id" {
  type    = string
  default = null
}

variable "ipv4_netmask_length" {
  type    = number
  default = null
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "enable_classic_link" {
  type    = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  type    = bool
  default = false
}

variable "ipv6_cidr_block" {
  type    = string
  default = null
}

variable "ipv6_ipam_pool_id" {
  type    = string
  default = null
}

variable "ipv6_netmask_length" {
  type    = number
  default = 56

  validation {
    condition     = length(var.ipv6_netmask_length) == 56
    error_message = "IPv6 Netmask length is not equal to 56."
  }
}

variable "ipv6_cidr_block_network_border_group" {
  type    = string
  default = null
}

variable "assign_generated_ipv6_cidr_block" {
  type    = bool
  default = false
}