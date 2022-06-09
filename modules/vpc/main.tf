resource "aws_vpc" "main" {
  cidr_block                       = length(var.ipv4_netmask_length) > 0 ? null : var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  ipv4_ipam_pool_id                = var.ipv4_ipam_pool_id
  ipv4_netmask_length              = length(var.cidr_block) > 0 ? null : var.ipv4_netmask_length
  ipv6_cidr_block                  = length(var.ipv6_netmask_length) > 0 ? null : var.ipv6_cidr_block
  ipv6_ipam_pool_id                = var.ipv6_ipam_pool_id
  ipv6_netmask_length              = length(var.ipv6_cidr_block) > 0 ? null : var.ipv6_netmask_length
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.enable_classic_link
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = length(var.ipv6_ipam_pool_id) > 0 ? null : var.assign_generated_ipv6_cidr_block
  tags                             = var.tags
}