# locals block is used here to define common tags for the resources defined below
locals {
  Environment = "Dev"
  Owner       = "HashiCorp Learners"
}

# VPC resource block below
resource "aws_vpc" "my_new_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "main_vpc_project"
    Environment = local.Environment
    Owner       = local.Owner
  }
}
