
output "Network_Name" {
  value = "${google_compute_network.kubernetes-the-hard-way.name}"
}

output "SubnetNetwork_Name" {
  value = "${google_compute_network.kubernetes.name}"
}
