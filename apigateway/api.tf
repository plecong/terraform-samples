resource "aws_api_gateway_rest_api" "_" {
  name        = "api"
  description = "_"
}

resource "aws_api_gateway_resource" "_" {
  path_part   = "{proxy+}"
  parent_id   = "${aws_api_gateway_rest_api._.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
}

resource "aws_api_gateway_gateway_response" "_" {
  rest_api_id   = "${aws_api_gateway_rest_api._.id}"
  status_code   = "403"
  response_type = "MISSING_AUTHENTICATION_TOKEN"

  response_templates = {
    "application/json" = <<EOF
{
    "message": $context.error.messageString,
}
EOF
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "${var.cors_headers}"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "${var.cors_methods}"
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "${var.cors_origin}"
  }
}

resource "aws_api_gateway_deployment" "_" {
  rest_api_id = "${aws_api_gateway_rest_api._.id}"
  stage_name  = "test"

  variables {
    deployed_at = "${timestamp()}"
  }

  depends_on = [
    "aws_api_gateway_integration.root_integration",
    "aws_api_gateway_integration.any_integration",
    "aws_api_gateway_integration.options_integration",
  ]
}
