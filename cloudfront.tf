resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.domain_name}"
}

resource "aws_cloudfront_distribution" "cf_dist" {
  enabled             = true
  aliases             = [var.domain_name, "www.${var.domain_name}"]
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.bucket.id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    "Name"          = var.project
    "Project"       = var.project
    "Environment"   = var.environment
    "ManagedBy" = "Terraform"
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}