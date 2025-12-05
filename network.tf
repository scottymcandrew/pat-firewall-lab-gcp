# Blue VPC Network
resource "google_compute_network" "blue_vpc" {
  name                    = "blue-vpc"
  auto_create_subnetworks = false
}

# Red VPC Network
resource "google_compute_network" "red_vpc" {
  name                    = "red-vpc"
  auto_create_subnetworks = false
}

# Blue Subnet (10.1.1.0/24)
resource "google_compute_subnetwork" "blue_subnet" {
  name          = "blue-subnet"
  ip_cidr_range = "10.1.1.0/24"
  region        = var.region
  network       = google_compute_network.blue_vpc.id
}

# Red Subnet (10.1.2.0/24)
resource "google_compute_subnetwork" "red_subnet" {
  name          = "red-subnet"
  ip_cidr_range = "10.1.2.0/24"
  region        = var.region
  network       = google_compute_network.red_vpc.id
}
