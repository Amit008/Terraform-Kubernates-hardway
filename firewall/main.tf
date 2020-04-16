
###Create firewall rules
resource "google_compute_firewall" "default" {
  name    = "kubernetes-the-hard-way-allow-external"
  network = "kubernetes-the-hard-way"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}
