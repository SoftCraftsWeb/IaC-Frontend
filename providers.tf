terraform {
  required_providers {
    aws = {
      version = ">= 4.25.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}