variable "aws_region" {
  default = "ap-south-1"
}
variable "env" {
  default = "dev"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}
variable "public_subnet_cidr_two" {
  default = "10.0.3.0/24"
}
variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "all_traffic_cidr" {
  default = "0.0.0.0/0"
}
variable "HTTP_port" {
  default = "80"
}
variable "SSH_port" {
  default = "22"
}
variable "az1" {
  default = "ap-south-1a"
}
variable "az2" {
  default = "ap-south-1b"
}
variable "az3" {
  default = "ap-south-1c"
}
variable "ec2_ami" {
  default = "ami-0fd05997b4dff7aac"
}
variable "instance_type" {
  default = "t2.micro"
  type    = string
}