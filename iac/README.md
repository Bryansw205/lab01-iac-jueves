# DESPLIEGUE
Ahora para el despliegue vamos a necesitar instalar el terraform en nuestro entorno de trabajo.
Para esto nos vamos a la documentacion oficial en donde nos brindan los pasos a seguir que son ejecutar los siguientes comandos en orden:

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

Ahora ya tenemos instalado Terraform en nuestro entorno pasamos a habilitar los proveedores dirigiendonos a la carpeta "iac"

cd iac

terraform init

Aqui tenemos 2 "workspace" o mesas de trabajo y una opcional, son localhost, dev y default(opcional). 
Para crear uno de estas mesas utilizamos el siguiente comando:

terraform workspace new "nombre-mesa"

Luego para seleccionar seria:

terraform workspace select "nombre-mesa"

Estos workspace nos permite manejar los puertos en donde se estan ejecutando cada uno de nuestras capas, se encuentra dentro del archivo:

terraform.tfvars

web_port={
    default = 3001
    localhost = 4001
    dev = 5001
}

api_port={
    default = 3002
    localhost = 4002
    dev = 5002
}

bd_port={
    default = 3003
    localhost = 4003
    dev = 5003
}

Tambien para este caso se uso una red de docker la cual fue configurada en el archivo:

red.tf

resource "docker_network" "app_network" {
  name = "app-network-${terraform.workspace}"
}

Permite abrir una red segun la mesa que estemos usando, esta tambien tenemos que agregar en cada uno de los archivos de las capas que tengamos, web, api y bd.

Luego para ejecutar todo procederiamos en este orden:

cd iac

terraform init

terraform workspace select dev

terraform plan

terraform apply

Confirmamos con Yes