output "Name" {
  value = "${join(" ", google_compute_instance.test.*.name)}"
}

output "Instance_IPs" {
  value = "${join(" ", google_compute_instance.test.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
