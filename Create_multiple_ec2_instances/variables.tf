variable "region" {
  description = "This variable contains the region where resources will be deployed"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "This variable contains the ec2 instance type to be launched in aws"
  default     = "t2.micro"
}
