resource "google_compute_subnetwork" "kubernetes" {
  name          = "kubernetes"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-west4"
  network       = google_compute_network.kubernetes-the-hard-way.self_link
  
}

resource "google_compute_network" "kubernetes-the-hard-way" {
  name                    = "kubernetes-the-hard-way"
  auto_create_subnetworks = false
}

resource "google_compute_address" "kubernetes-the-hard-way" {
  name = "kubernetes-the-hard-way"
address_type="EXTERNAL"
region="europe-west4"
network_tier="STANDARD"
}
