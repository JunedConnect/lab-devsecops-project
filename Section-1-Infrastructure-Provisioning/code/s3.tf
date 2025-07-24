resource "aws_s3_bucket" "application-logs" {
  bucket = "juned-application-logs"
}

resource "aws_s3_bucket" "service-backups" {
  bucket = "juned-service-backups"
}

resource "aws_s3_bucket" "application-data" {
  bucket = "juned-application-data"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "application-logs" {
  bucket = aws_s3_bucket.application-logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "service-backups" {
  bucket = aws_s3_bucket.service-backups.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "application-data" {
  bucket = aws_s3_bucket.application-data.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_kms_key" "this" {
  is_enabled               = true
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    enable_key_rotation = "true"
    rotation_period_in_days = 90
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket_versioning" "application-logs" {
  bucket = aws_s3_bucket.application-logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "service-backups" {
  bucket = aws_s3_bucket.service-backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "application-data" {
  bucket = aws_s3_bucket.application-data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "application-logs" {
  bucket = aws_s3_bucket.application-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "service-backups" {
  bucket = aws_s3_bucket.service-backups.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "application-data" {
  bucket = aws_s3_bucket.application-data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}