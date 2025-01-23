variable "aws_region" {
  description = "This is the region in which resources will be deployed"
  type        = string
  default     = "ap-south-1"
}
variable "ami_id" {
  description = "This is the AMI ID for the ap-south-1 region"
  type        = string
  default     = "ami-0d2614eafc1b0e4d2"
}
variable "instance_type_ec2" {
  description = "This is the EC2 instance type that will be used"
  default     = "t2.micro"
  type        = string
}
variable "vpc_CIDR" {
  description = "This will be the main VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}
variable "publicsubnet1" {
  description = "This will be the public subnet1 CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}
variable "publicsubnet2" {
  description = "This will be the public subnet2 CIDR block"
  type        = string
  default     = "10.0.2.0/24"
}
variable "all_cidr" {
  description = "Traffic CIDR other than VPC CIDR"
  default     = "0.0.0.0/0"
  type        = string
}
variable "min_size" {
  description = "Minimum number of instances of ASG instances"
  default     = 2
  type        = number
}
variable "max_size" {
  description = "Maximum number of instances of ASG instances"
  default     = 10
  type        = number
}
variable "desired_capacity" {
  description = "Desired number of instances of ASG instances"
  default     = 2
  type        = number
}
variable "ssh_port" {
  description = "SSH port number"
  default     = 22
  type        = number
}
variable "http_port" {
  description = "HTTP port number"
  default     = 80
  type        = number
}
variable "http_protocol" {
  description = "HTTP protocol name"
  type        = string
  default     = "HTTP"
}