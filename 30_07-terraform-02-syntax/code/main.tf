#Provaider
provider "yandex" {
  token     = ""
  cloud_id  = "b1ghoagi59974h152cps"
  folder_id = "b1gdfjvui9oh3lot5cqe"
  zone      = "ru-central-1a"
}

resource "yandex_compute_instance" "node1" {
  name                      = "node1"
  zone                      = "ru-central1-a"
  hostname                  = "node1.netology.yc"
  allow_stopping_for_update = true

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd87tirk5i8vitv9uuo1" #ubuntu
      name        = "node1"
      type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.default.id}"
    nat        = true
    ip_address = "192.168.101.11"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Network
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}