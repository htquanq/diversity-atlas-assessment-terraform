variable "name" {
  type = string
  validation {
    condition     = length(var.name) > 0
    error_message = "Name of ASG should be greater than zero. Please check again."
  }
}

variable "min_size" {
  type    = number
  default = 0
}

variable "protect_from_scale_in" {
  type    = bool
  default = false
}

variable "max_size" {
  type    = number
  default = 0
}

variable "desired_capacity" {
  type    = number
  default = 0
}

variable "vpc_zone_identifier" {
  type    = list(any)
  default = []
}

variable "tags" {
  default = {}
}

variable "health_check_type" {
  type    = string
  default = "EC2"
}

variable "suspended_processes" {
  default = []
}

variable "termination_policies" {
  default = ["Default"]
}

variable "mixed_instances_policy" {
  default = []
}

variable "launch_template" {
  default = []
}

variable "instance_refresh" {
  default = {}
}