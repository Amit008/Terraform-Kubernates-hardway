output "External_IP" {
  value = "${google_compute_instances.default.network_interface.0.access_config.0.nat_ip}"
}

output "Internal_IP" {
  value = "${google_compute_instances.default.default.network_interface.0.networkIP}"
}
