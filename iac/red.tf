resource "docker_network" "app_network" {
  name = "app-network-${terraform.workspace}"
}