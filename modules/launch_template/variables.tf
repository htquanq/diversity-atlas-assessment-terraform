variable "name" {
  type = string
  validation {
    condition     = length(var.name) > 0
    error_message = "Name of ASG should be greater than zero. Please check again."
  }
}

variable "image_id" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "disable_api_termination" {
  type    = bool
  default = true
}

variable "ebs_optimized" {
  type    = bool
  default = false
}

variable "instance_initiated_shutdown_behavior" {
  type    = string
  default = "terminate"
}

variable "key_name" {
  type = string
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = []
}

variable "user_data" {
  type    = string
  default = null
}

variable "cpu_options" {
  default = []
}

variable "block_device_mappings" {
  default = []
}
variable "credit_specification" {
  default = []
}
variable "iam_instance_profile" {
  default = []
}
variable "instance_market_options" {
  default = []
}
variable "monitoring" {
  default = []
}
variable "network_interfaces" {
  default = []
}

variable "update_default_version" {
  type    = bool
  default = true
}

variable "instance_type" {
  default = "t3.small"
}