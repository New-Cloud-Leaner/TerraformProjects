resource "aws_dynamodb_table" "project_dynamodb_table" {
  name = var.table_name
  hash_key = var.parition_key
  billing_mode = var.billing_mode

  #provisioned throughput(if using provisioned here)
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = var.parition_key
    type = "S" # S stands for string
  }

  tags = {
    Name = var.table_name
    Environment="Dev"
    Project="Terraform Project Dynamodb table"
  }
}
