variable "vpc_cidr" {
  description = "CIDR Block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "map of public subnets and azs"
  type = map(object({
    cidr = string
    az   = string
  }))
}
