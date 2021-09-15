resource "aws_api_gateway_resource" usuarios {
  parent_id = aws_api_gateway_rest_api.api-terraform.root_resource_id
  path_part = "usuarios"
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id
}