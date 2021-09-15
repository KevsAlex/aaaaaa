//API GATEWAY
resource "aws_api_gateway_rest_api" api-terraform {
  name = "api-gateway-terraform-ex"
}

//Prod deployment
resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.usuarios.id,
      aws_api_gateway_method.get-user.id,
      aws_api_gateway_integration.get-user-integration.id,



    ]))


    //description = "Deployed at ${timestamp()}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_stage" "prod_stage" {
  stage_name = "prod"
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
}

resource "aws_api_gateway_stage" "test-stage" {
  stage_name = "test"
  rest_api_id = aws_api_gateway_rest_api.api-terraform.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
}





