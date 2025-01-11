output "alb_dns_name" {
  value = aws_alb.app_lb.dns_name
}
output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}