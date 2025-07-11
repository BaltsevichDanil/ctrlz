# VPC Network
resource "yandex_vpc_network" "ctrlz_network" {
  name        = "ctrlz-network"
  description = "Network for CtrlZ microfrontends"
  folder_id   = var.folder_id

  labels = {
    environment = "production"
    project     = "ctrlz"
  }
}

# Subnets in different availability zones
resource "yandex_vpc_subnet" "ctrlz_subnet_a" {
  name           = "ctrlz-subnet-a"
  description    = "Subnet in zone A"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.ctrlz_network.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  folder_id      = var.folder_id

  labels = {
    environment = "production"
    project     = "ctrlz"
    zone        = "a"
  }
}

resource "yandex_vpc_subnet" "ctrlz_subnet_b" {
  name           = "ctrlz-subnet-b"
  description    = "Subnet in zone B"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.ctrlz_network.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  folder_id      = var.folder_id

  labels = {
    environment = "production"
    project     = "ctrlz"
    zone        = "b"
  }
}

resource "yandex_vpc_subnet" "ctrlz_subnet_d" {
  name           = "ctrlz-subnet-d"
  description    = "Subnet in zone D"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.ctrlz_network.id
  v4_cidr_blocks = ["10.0.3.0/24"]
  folder_id      = var.folder_id

  labels = {
    environment = "production"
    project     = "ctrlz"
    zone        = "d"
  }
} 