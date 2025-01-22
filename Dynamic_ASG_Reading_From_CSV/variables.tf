variable "aws_region" {
  description = "The region of the resources deployed"
  default     = "ap-south-1"
}
variable "instance_type" {
  description = "the instance type used for the ASG"
  default     = "t2.micro"
}

variable "ami" {
  description = "the ami for the instances using Free tier amazon Linux 2023 AMI"
  default     = "ami-0d2614eafc1b0e4d2"
}

variable "CIDR_block_vpc" {
  description = "CIDR block of the main VPC"
  default     = "10.0.0.0/16"
}

variable "CIDR_block_public1" {
  description = "CIDR block of the subnet public1"
  default     = "10.0.1.0/24"
}

variable "CIDR_block_public2" {
  description = "CIDR block of the subnet public1"
  default     = "10.0.2.0/24"
}