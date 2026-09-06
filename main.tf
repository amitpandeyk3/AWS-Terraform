resource "aws_s3_bucket" "learning" {
  bucket_prefix = local.bucket_name_prefix
  tags          = local.common_tags
}