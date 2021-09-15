output my_ip_url {
  value = "${aws_api_gateway_deployment.api-deployment.invoke_url}${aws_api_gateway_resource.usuarios.path_part}"
}