terraform {
  backend "s3" {
    bucket = "doubtbuckit"
    key = "day-1/terraform.tfstate"
    region = "us-east-1"
  }
}