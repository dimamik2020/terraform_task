provider "google" {
  credentials = file("credentials.json")
  project     = "fleet-goal-286112"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
  region = "europe-west3"
}

resource "google_compute_instance" "terraform-task-instance" {
  name         = "terraform-task-instance"
  machine_type = "g1-small"
  zone         = "europe-west3-a"
  tags = ["terraform-task"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20200807"
    }
  }
  network_interface {
  #network = "default"
  network = google_compute_network.terraform-task-network.self_link
        access_config {
        nat_ip = google_compute_address.static.address
                      }
                    }

metadata = {
       ssh-keys = "ubuntu:${file("id_rsa.pub")}"
          }


}

resource "google_compute_firewall" "terraform-task-firewall-web" {
  name    = "terraform-task-firewall-web"
  network = google_compute_network.terraform-task-network.name


  allow {
    protocol = "tcp"
    ports    = ["80","443"]
        }

}

resource "google_compute_firewall" "terraform-task-firewall-ssh" {
  name    = "terraform-task-firewall-ssh"
  network = google_compute_network.terraform-task-network.name


  allow {
    protocol = "tcp"
    ports    = ["22"]

        }

  source_ranges = ["82.207.102.102"]
}


resource "google_compute_network" "terraform-task-network" {
  name = "terraform-task-network"
  auto_create_subnetworks = "true"
}
