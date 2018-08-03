resource "aws_api_gateway_method" "root_method" {
  rest_api_id   = "${aws_api_gateway_rest_api._.id}"
  resource_id   = "${aws_api_gateway_rest_api._.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_integration" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.root_method.resource_id}"
  http_method = "${aws_api_gateway_method.root_method.http_method}"
  type        = "MOCK"

  request_templates {
    "application/json" = <<EOF
{
    "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_integration_response" "root_integration_response" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.root_method.resource_id}"
  http_method = "${aws_api_gateway_method.root_method.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "${var.cors_headers}"
    "method.response.header.Access-Control-Allow-Methods" = "${var.cors_methods}"
    "method.response.header.Access-Control-Allow-Origin"  = "${var.cors_origin}"
  }

  depends_on = ["aws_api_gateway_integration.root_integration"]
}

resource "aws_api_gateway_method_response" "root_method_response" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  resource_id = "${aws_api_gateway_method.root_method.resource_id}"
  http_method = "${aws_api_gateway_method.root_method.http_method}"
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
