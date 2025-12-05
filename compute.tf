# PAT Firewall VM - Dual NIC with IP forwarding
resource "google_compute_instance" "pat_firewall" {
  name         = "pat-firewall"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["pat-firewall", "ssh-access"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Primary NIC on blue subnet (with external IP)
  network_interface {
    subnetwork = google_compute_subnetwork.blue_subnet.id
    network_ip = var.pat_blue_nic_ip

    access_config {
      # Ephemeral external IP
    }
  }

  # Secondary NIC on red subnet (internal only)
  network_interface {
    subnetwork = google_compute_subnetwork.red_subnet.id
    network_ip = var.pat_red_nic_ip
  }

  # Enable IP forwarding for NAT
  can_ip_forward = true

  metadata_startup_script = file("${path.module}/scripts/pat-firewall.sh")

  # Ensure web servers are created first
  depends_on = [
    google_compute_instance.blue_webserver,
    google_compute_instance.red_webserver
  ]
}

# Blue Web Server
resource "google_compute_instance" "blue_webserver" {
  name         = "blue-webserver"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh-access", "webserver"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.blue_subnet.id
    network_ip = var.blue_server_ip
    # No external IP - internal only
  }

  metadata_startup_script = file("${path.module}/scripts/blue-webserver.sh")
}

# Red Web Server
resource "google_compute_instance" "red_webserver" {
  name         = "red-webserver"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh-access", "webserver"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.red_subnet.id
    network_ip = var.red_server_ip
    # No external IP - internal only
  }

  metadata_startup_script = file("${path.module}/scripts/red-webserver.sh")
}
