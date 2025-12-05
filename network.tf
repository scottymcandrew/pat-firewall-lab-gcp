# VPC Network
resource "google_compute_network" "pat_lab_vpc" {
  name                    = "pat-lab-vpc"
  auto_create_subnetworks = false
}

# Blue Subnet (10.1.1.0/24)
resource "google_compute_subnetwork" "blue_subnet" {
  name          = "blue-subnet"
  ip_cidr_range = "10.1.1.0/24"
  region        = var.region
  network       = google_compute_network.pat_lab_vpc.id
}

# Red Subnet (10.1.2.0/24)
resource "google_compute_subnetwork" "red_subnet" {
  name          = "red-subnet"
  ip_cidr_range = "10.1.2.0/24"
  region        = var.region
  network       = google_compute_network.pat_lab_vpc.id
}
