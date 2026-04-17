resource "docker_container" "bd" {
  name  = "bd-${terraform.workspace}"
  image = "lab/bd"

   ports {
    internal = "5432"
    external = var.bd_port[terraform.workspace]
  }

    networks_advanced {
    name = docker_network.app_network.name
  }
}
