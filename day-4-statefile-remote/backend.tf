terraform {
  backend "s3" {
    bucket = "doubtbuckit"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}