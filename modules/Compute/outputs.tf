output "External_ips" {
  value = "${join(" ",google_compute_instance.Compute-group-1.*.network_interface.0.access_config.0.nat_ip)}"
}

output "Internal_ips" {
  value = "${join(" ",google_compute_instance.Compute-group-1.*.network_interface.0.network_ip)}"
}
