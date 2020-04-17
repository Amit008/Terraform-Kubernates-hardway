
output "network_id" {
  value = "${google_compute_network.kubernetes-the-hard-way.id}"
}

output "subnet_id" {
  value = "${google_compute_network.kubernetes.id}"
}
