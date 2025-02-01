resource "aws_cloudfront_distribution" "web_cdn" {
  # Define the origin where CloudFront will fetch content (ALB in this case)
  origin {
    domain_name = var.alb_dns_name  # ALB's DNS name (provided as a variable)
    origin_id   = "ALBOrigin"       # A unique ID for the origin

    # Define how CloudFront communicates with the origin (ALB)
    custom_origin_config {
      http_port              = 80                  # ALB listens on port 80 (HTTP)
      https_port             = 443                 # ALB can also listen on HTTPS (not used here)
      origin_protocol_policy = "http-only"         # CloudFront will use HTTP to communicate with ALB
      origin_ssl_protocols   = ["TLSv1.2"]         # SSL protocols (only used if HTTPS is enabled)
    }
  }

  enabled             = true                       # Enables CloudFront distribution
  default_root_object = "index.html"              # The default file CloudFront will serve

  # Configure cache behavior for requests
  default_cache_behavior {
    target_origin_id       = "ALBOrigin"          # The origin CloudFront should use (ALB)
    viewer_protocol_policy = "redirect-to-https"  # Redirect all HTTP requests to HTTPS
    allowed_methods        = ["GET", "HEAD", "OPTIONS"] # Allowed HTTP methods
    cached_methods         = ["GET", "HEAD"]      # Only cache GET and HEAD requests

    # Configure how CloudFront handles query strings and cookies
    forwarded_values {
      query_string = false   # Do not forward query strings to the origin
      cookies {
        forward = "none"     # Do not forward cookies to the origin
      }
    }

    # Define caching behavior
    min_ttl     = 0          # Minimum time to live (TTL) for cached objects
    default_ttl = 3600       # Default TTL (1 hour)
    max_ttl     = 86400      # Maximum TTL (1 day)
  }

  # Restrict access based on geolocation (not applied here)
  restrictions {
    geo_restriction {
      restriction_type = "none"  # No geo-restrictions (accessible globally)
    }
  }

  # Enable HTTPS using CloudFront’s default SSL certificate
  viewer_certificate {
    cloudfront_default_certificate = true  # Use AWS-provided SSL certificate
  }

  # Tags for resource identification
  tags = {
    Name = "WebCDN"
  }
}
