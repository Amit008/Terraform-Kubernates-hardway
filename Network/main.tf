
###Create VPC
resource "google_compute_network" "default" {
  name = "kubernetes-the-hard-way"
  auto_create_subnetworks=false
}
