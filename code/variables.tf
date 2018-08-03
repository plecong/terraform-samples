variable "bucket_prefix" {
  type    = "string"
  default = "plecong"
}

variable "github_owner" {
  type = "string"
  default = "plecong" // it me
}

variable "github_repo" {
  type = "string"
  default = "terraform-samples"
}

variable "github_branch" {
  type = "string"
  default = "master"
}

// See https://docs.aws.amazon.com/codepipeline/latest/userguide/GitHub-rotate-personal-token-CLI.html
variable "github_oauth_token" {
  type = "string"
}
