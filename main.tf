provider "aws" {
  region = "us-east-1"
}

module "code" {
  source             = "./code"
  github_oauth_token = "${var.github_oauth_token}"
}

variable "github_oauth_token" {}
