terraform {
  # fix the provider version
  version = "1"

  #add role_arn to use assumed roles to access the bucket
  backend "s3" {
    encrypt        = true
    bucket         = "553700203877-terraform-state"
    key            = "lexbot/terraform.tfstate"
    dynamodb_table = "dynamodb-state-lock"
    region         = "eu-west-1"
    profile        = "saml"
  }
}
