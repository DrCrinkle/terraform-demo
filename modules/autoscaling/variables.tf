variable "desired" {
  type        =  number
  description = "set desired capacity for auto scaling group here"
}

variable "min" {
  type        =  number
  description = "set minimum size for auto scaling group here"
}

variable "max" {
  type        =  number
  description = "set maximum size for auto scaling group here"
}

variable "vpc" {
  type        =  string
}

variable "subnets" {
  type        =  list(string)
}

variable "target_group" {
  type        =  string
}

variable "elb" {
  type        =  string
}

variable "efs_dns" {
  type        = string
}
