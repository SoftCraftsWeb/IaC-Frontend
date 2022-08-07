resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags = {
    "Name"          = var.project
    "Project"       = var.project
    "Environment"   = var.environment
    "ManagedBy"     = "Terraform"
  }
}

resource "aws_route53_record" "websiteurl" {
  name    = var.domain_name
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_dist.domain_name
    zone_id                = aws_cloudfront_distribution.cf_dist.hosted_zone_id
    evaluate_target_health = true
  }
}