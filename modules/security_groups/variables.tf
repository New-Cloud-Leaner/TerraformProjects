variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_groups" {
  description = "map of the security groups with rules"
  type = map(object({
    ingress_rules = list(object({
      to_port     = number
      from_port   = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      to_port     = number
      from_port   = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
