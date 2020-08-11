provider "google" {
  credentials = file("credentials.json")
  project     = "fleet-goal-286112"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "g1-small"
  zone         = "europe-west3-a"
  tags = ["dimamik", "terraformed"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20200807"
    }
  }
}
