# VPC creation
resource "google_compute_network" "test_vpc" {
  project                 = var.project_id
  name                    = "vpc-test-posture"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# Subnet creation
resource "google_compute_subnetwork" "test_subnet" {
  name          = "snet-test-posture"
  project       = var.project_id
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-east4"
  private_ip_google_access = false     
  network       = google_compute_network.test_vpc.id
}

