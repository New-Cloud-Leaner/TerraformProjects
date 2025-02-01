variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
}
variable "security_group_id" {
  description = "Security group ID for the ec2"
  type        = string
}
variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = "my-manual-key"
}
variable "subnets" {
  description = "map of subnets"
  type        = map(string)
}