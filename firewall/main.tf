gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  source-ranges [10.240.0.0/24,10.200.0.0/16"]


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
