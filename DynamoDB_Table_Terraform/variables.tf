variable "aws_region" {
  description = "This is the aws region"
  default = "Enter region of your choice"
}

variable "table_name" {
  description = "This is the name of the dynamodb table"
  default = "Enter name of the DynamoDB table"
}

variable "parition_key" {
  description = "The partition key for dynamodb table"
  default = "ID" # select your partition ID is selected here
}

variable "billing_mode" {
  description = "billing mode for dynamodb pay per request or provisioned"
  default = "PROVISIONED" #select your billing provisioned is selected here
}

variable "read_capacity" {
  description = "RCU for provisioned mode"
  default = 5 # enter your RCU value of 5 is selected here
}

variable "write_capacity" {
  description = "WCU for provisioned mode"
  default = 5 # enter your WCU value of 5 is selected here
}