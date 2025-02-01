# Output CloudFront’s domain name so we can access it
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.web_cdn.domain_name
}
