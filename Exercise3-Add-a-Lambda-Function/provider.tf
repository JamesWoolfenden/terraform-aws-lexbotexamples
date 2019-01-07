provider "aws" {
  region  = "eu-west-1"
  version = "1.54"
  profile = "saml"
}

provider "null" {
  version = "1.0"
}

provider "archive" {
  version="1.1"
}

provider "local" {
version = "1.1"
}

provider "template" {
  version = "1.0"}