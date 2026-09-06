variable "bucket_prefix" {
  description = "Prefix used for the S3 bucket name"
  type        = string
  default     = "terraform-learning-"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-learning"
}