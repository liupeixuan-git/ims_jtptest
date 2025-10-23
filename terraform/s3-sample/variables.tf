variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "acl" {
  description = "ACL for the bucket (defaults to private). Note: ACLs may be deprecated depending on provider version."
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to attach to the bucket"
  type        = map(string)
  default     = {}
}
