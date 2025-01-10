output "frontend_pips" {
  value = aws_instance.frontend[*].public_ip
}