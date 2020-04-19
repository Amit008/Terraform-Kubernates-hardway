output "External_IP" {
  value = "${google_compute_subnetwork.kubernetes.name}"
}

output "Internal_IP" {
  value = "${google_compute_instance}"
}
