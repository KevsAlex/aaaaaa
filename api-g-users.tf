resource "aws_api_gateway_method" get-user {
  authorization = "NONE"
  http_method = "GET"
  resource_id = aws_api_gateway_resource.usuarios.id
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id
}

resource "aws_api_gateway_integration" get-user-integration {
  http_method = aws_api_gateway_method.get-user.http_method
  resource_id = aws_api_gateway_resource.usuarios.id
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id
  type = "MOCK"

  request_templates = {
    "application/json" = <<TEMPLATE
      {
        "statusCode": 200
      }
    TEMPLATE
  }
}

resource aws_api_gateway_method_response my_ip {
  rest_api_id = aws_api_gateway_method.get-user.rest_api_id
  resource_id = aws_api_gateway_method.get-user.resource_id
  http_method = aws_api_gateway_method.get-user.http_method
  status_code = 200
}

resource aws_api_gateway_integration_response usuario_response {
  rest_api_id = aws_api_gateway_integration.get-user-integration.rest_api_id
  resource_id = aws_api_gateway_integration.get-user-integration.resource_id
  http_method = aws_api_gateway_integration.get-user-integration.http_method
  status_code = 200
  response_templates = {
    "application/json" = <<TEMPLATE
{
    "ip" : "$context.identity.sourceIp",
    "Holis" : "Crayoliss"
    "userAgent" : "$context.identity.userAgent",
    "time" : "$context.requestTime",
    "epochTime" : "$context.requestTimeEpoch"
}
TEMPLATE
  }
}


