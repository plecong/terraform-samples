variable "cors_methods" {
  type    = "string"
  default = "'DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT'"
}

variable "cors_headers" {
  type    = "string"
  default = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
}

variable "cors_origin" {
  type    = "string"
  default = "'*'"
}
