output "instance_ids" {
  value = { for k, v in aws_instance.web : k => v.id }
}

output "public_ip" {
  value = { for k, v in aws_instance.web : k => v.public_ip }
}
