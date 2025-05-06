# Generate a random suffix for the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create the S3 bucket with a unique name
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
}

# (Optional) S3 Bucket ACL — uncomment if needed
# resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = var.bucket_acl
# }

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
