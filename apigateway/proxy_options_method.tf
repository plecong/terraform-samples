resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = "${aws_api_gateway_rest_api._.id}"
  resource_id   = "${aws_api_gateway_resource._.id}"
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.options_method.resource_id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  type        = "MOCK"

  request_templates {
    "application/json" = <<EOF
{
    "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.options_method.resource_id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "${var.cors_headers}"
    "method.response.header.Access-Control-Allow-Methods" = "${var.cors_methods}"
    "method.response.header.Access-Control-Allow-Origin"  = "${var.cors_origin}"
  }

  depends_on = ["aws_api_gateway_integration.options_integration"]
}

resource "aws_api_gateway_method_response" "options_method_response" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.options_method.resource_id}"
  http_method = "${aws_api_gateway_method.options_method.http_method}"
  status_code = "200"

  response_models {
    "application/json" = "Empty"
  }

  response_parameters {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}
