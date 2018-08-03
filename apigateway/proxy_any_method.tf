resource "aws_api_gateway_method" "any_method" {
  rest_api_id   = "${aws_api_gateway_rest_api._.id}"
  resource_id   = "${aws_api_gateway_resource._.id}"
  http_method   = "ANY"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "any_integration" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.any_method.resource_id}"
  http_method = "${aws_api_gateway_method.any_method.http_method}"
  type        = "MOCK"

  # Transforms the incoming XML request to JSON
  request_templates {
    "application/json" = <<EOF
{
   "body" : "hello"
}
EOF
  }
}
