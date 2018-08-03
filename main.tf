provider "aws" {
  region = "us-east-1"
}

module "apigateway" {
  source = "./apigateway"
}
