variable "environment" {
  description = "Environment tag for the bucket"
  type        = string
  default     = "dev"
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

