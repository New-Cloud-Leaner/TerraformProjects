variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "list of public subnet ids"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "security group id for alb"
  type        = string
}

variable "ec2_instance_ids" {
  description = "map of ec2 instance ids"
  type        = map(string)
}