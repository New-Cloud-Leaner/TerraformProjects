output "security_groups_ids" {
  value = { for k, v in aws_security_group.sg : k => v.id }
}