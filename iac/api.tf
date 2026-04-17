resource "docker_container" "api" {
  name  = "api-${terraform.workspace}"
  image = "lab/api"

   ports {
    internal = "3000"
    external = var.api_port[terraform.workspace]
  }
}