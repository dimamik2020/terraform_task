provider "google" {
  credentials = file("credentials.json")
  project     = "fleet-goal-286112"
  region      = "us-central1"
  zone        = "us-central1-c"
}
