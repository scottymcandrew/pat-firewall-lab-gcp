# Allow external access to PAT firewall on ports 8081 and 8082
resource "google_compute_firewall" "allow_pat_ingress" {
  name    = "allow-pat-ingress"
  network = google_compute_network.pat_lab_vpc.name

  allow {
    protocol = "tcp"
    ports    = [var.blue_port, var.red_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pat-firewall"]
}

# Allow SSH for management
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.pat_lab_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"]
}

# Allow internal traffic between subnets (for PAT translation)
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.pat_lab_vpc.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.1.1.0/24", "10.1.2.0/24"]
}
