variable "aws_region" {
  description = "This block contains the region where the vpc and its components will be deployed"
  default     = "us-east-2" # add your region here
}

variable "vpc_cidr_block" {
  description = "This block contains the CIDR block of the main VPC"
  default     = "10.0.0.0/16" #add your CIDR block here for vpc
}

variable "public_subnet_cidr_block" {
  description = "This block contains the CIDR block of the public subnet"
  default     = "10.0.1.0/24" # add your cidr block here for public subnet
}

variable "private_subnet_cidr_block" {
  description = "This block contains the CIDR block of the private subnet"
  default     = "10.0.2.0/24" # add your cidr block here for private subnet
}

variable "all_traffic_cidr" {
  description = "This block contains the CIDR block for internet for IGW"
  default     = "0.0.0.0/0"
}