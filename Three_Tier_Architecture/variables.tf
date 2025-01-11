variable "region" {
  default = "ap-south-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "availability_zone" {
  default = ["ap-south-1a", "ap-south-1b"]
}
variable "HTTP_port" {
  default = "80"
}
variable "RDS_port" {
  default = "3306"
}
variable "db_user" {
  default = "YOUR USERNAME FOR DB SERVER"
}
variable "db_password" {
  default = "YOUR PASSWORD FOR DB SERVER"
}