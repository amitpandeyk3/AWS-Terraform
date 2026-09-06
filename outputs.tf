output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.learning.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.learning.arn
}

output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "Current AWS region"
  value       = data.aws_region.current.region
}