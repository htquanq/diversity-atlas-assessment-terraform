variable "peer_owner_id" {
  type    = string
  default = null
  validation {
    condition     = length(var.peer_owner_id) > 0
    error_message = "Peer owner ID is not valid, please check again."
  }
}

variable "peer_vpc_id" {
  type = string
  validation {
    condition     = length(var.peer_vpc_id) > 0
    error_message = "Peer VPC ID is not valid, please check again."
  }
}

variable "vpc_id" {
  type = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC ID is not valid, please check again."
  }
}

variable "auto_accept" {
  default = false
  type    = bool
}

variable "peer_region" {
  type    = bool
  default = false
}

variable "accepter" {
  type    = map(any)
  default = {}
}

variable "requester" {
  type    = map(any)
  default = {}
}

variable "tags" {
  default = {}
}