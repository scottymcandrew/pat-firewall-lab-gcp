output "pat_firewall_external_ip" {
  description = "External IP address of the PAT firewall"
  value       = google_compute_instance.pat_firewall.network_interface[0].access_config[0].nat_ip
}

output "blue_server_url" {
  description = "URL to access the blue web server via PAT"
  value       = "http://${google_compute_instance.pat_firewall.network_interface[0].access_config[0].nat_ip}:${var.blue_port}"
}

output "red_server_url" {
  description = "URL to access the red web server via PAT"
  value       = "http://${google_compute_instance.pat_firewall.network_interface[0].access_config[0].nat_ip}:${var.red_port}"
}

output "test_commands" {
  description = "Commands to test the PAT firewall"
  value       = <<-EOT
    # Test blue server (port ${var.blue_port} -> 10.1.1.3:80)
    curl http://${google_compute_instance.pat_firewall.network_interface[0].access_config[0].nat_ip}:${var.blue_port}

    # Test red server (port ${var.red_port} -> 10.1.2.3:80)
    curl http://${google_compute_instance.pat_firewall.network_interface[0].access_config[0].nat_ip}:${var.red_port}
  EOT
}
