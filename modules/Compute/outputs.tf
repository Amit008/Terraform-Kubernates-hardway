output "public_ip" {
  value = "${google_compute_address.kubernetes-the-hard-way.address}"
}


output "External_ips" {
  value = "${join(" ", google_compute_instance.compute.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "Internal_ips" {
  value = "${join(" ", google_compute_instance.compute.*.network_interface.0.network_ip)}"
}
