variable "vpc_cidr" {
  type        = string
  description = "set in here the CIDR for your VPC"
}

variable "env" {
  type        = string
  description = "set the env name here"
}

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
