output "dynamodb_table_name" {
  description = "The name of the Dynamodb table"
  value = aws_dynamodb_table.project_dynamodb_table.name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value = aws_dynamodb_table.project_dynamodb_table.arn
}