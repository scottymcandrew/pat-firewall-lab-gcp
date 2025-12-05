# Allow external access to PAT firewall on ports 8081 and 8082
resource "google_compute_firewall" "allow_pat_ingress" {
  name    = "allow-pat-ingress"
  network = google_compute_network.blue_vpc.name

  allow {
    protocol = "tcp"
    ports    = [var.blue_port, var.red_port]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pat-firewall"]
}

# Allow SSH for management - Blue VPC
resource "google_compute_firewall" "allow_ssh_blue" {
  name    = "allow-ssh-blue"
  network = google_compute_network.blue_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"]
}

# Allow SSH for management - Red VPC
resource "google_compute_firewall" "allow_ssh_red" {
  name    = "allow-ssh-red"
  network = google_compute_network.red_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"]
}

# Allow internal traffic in Blue VPC
resource "google_compute_firewall" "allow_internal_blue" {
  name    = "allow-internal-blue"
  network = google_compute_network.blue_vpc.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.1.1.0/24"]
}

# Allow internal traffic in Red VPC
resource "google_compute_firewall" "allow_internal_red" {
  name    = "allow-internal-red"
  network = google_compute_network.red_vpc.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.1.2.0/24"]
}
