
variable "aws_region" {
  description = "AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "image_url" {
  description = "Docker image URL for Medusa backend"
}

variable "database_url" {
  description = "Database connection string"
}
