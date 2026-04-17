resource "docker_container" "api" {
  name  = "api-${terraform.workspace}"
  image = "lab/api"

   ports {
    internal = "80"
    external = var.api_port[terraform.workspace]
  }
}