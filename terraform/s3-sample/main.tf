provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  tags = merge({
    Name = var.bucket_name
  }, var.tags)

  versioning {
    enabled = var.versioning
  }
}
