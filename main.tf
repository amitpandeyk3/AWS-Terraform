resource "aws_s3_bucket" "learning" {
  bucket        = "${var.bucket_prefix}${var.project_name}-${var.environment}"
  force_destroy = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-learning-bucket"
    Environment = var.environment
  }
}