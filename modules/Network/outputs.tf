
output "Network_Name" {
  value = "${google_compute_network.kubernetes-the-hard-way.name}"
}

output "SubNetwork_Name" {
  value = "${google_compute_subnetwork.kubernetes.name}"
}
