provider "google" {
  credentials = file("credentials.json")
  project     = "fleet-goal-286112"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
  region = "europe-west3-a"
}

resource "google_compute_instance" "terraform-task-instance" {
  name         = "terraform-task-instance"
  machine_type = "g1-small"
  zone         = "europe-west3-a"
  tags = ["dimamik", "terraformed"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20200807"
    }
  }
  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}

resource "google_compute_firewall" "terraform-task-firewall" {
  name    = "terraform-task-firewall"
  network = google_compute_network.default.name


  allow {
    protocol = "tcp"
    ports    = ["80","443"]
        }

  allow {
    protocol = "tcp"
    ports    = ["22"]

        }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "terraform-task-network"
}
