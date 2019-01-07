provider "aws" {
  region  = "eu-west-1"
  version = "1.54"
  profile = "saml"
}

provider "null" {
  version = "1.0"
}
