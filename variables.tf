variable "region" {  
  type        = string  
  default     = "us-east-1"  
  description = "The AWS Region to use."
}

variable "bucket_prefix" {  
  type        = string  
  default     = "oldwave.cf"
  description = "Name of the s3 bucket to be created."
} 

variable "domain_name" {
  type        = string
  description = "The domain name to use."
  default     = "oldwave"
}