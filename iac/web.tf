resource "docker_container" "web" {
  name  = "web-${terraform.workspace}"
  image = "lab/web"

   ports {
    internal = "80"
    external = var.web_port[terraform.workspace]
  }
}
