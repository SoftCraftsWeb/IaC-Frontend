resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags = {
    "Name"          = "OldWave"
    "Project"       = "OldWave"
    "Environment"   = "Production"
    "ManagedBy"     = "Terraform"
  }
}