#aws primary region
provider "aws" {
    alias = "primary"
    region = "us-east-1"
  
}

#aws secondary region
provider "aws" {
    alias = "secondary"
    region = "us-west-2"
  
}