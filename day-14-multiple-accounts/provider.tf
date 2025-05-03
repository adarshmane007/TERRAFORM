provider "aws" {
  profile = "dev"
  alias = "account1"
}

provider "aws" {
  profile = "prod"
  alias = "account2"
}
provider "aws" {
  profile = "staging"
  alias = "account3"
}