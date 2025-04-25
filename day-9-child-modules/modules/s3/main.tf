resource "aws_s3_bucket" "this" {
  bucket = "tiktikt"

  tags = {
    Name        = "tiktikt"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "this1" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

