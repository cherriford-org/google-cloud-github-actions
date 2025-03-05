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

resource "google_compute_instance" "default" {
  name         = "my-instance"
  project      = var.project_id
  machine_type = "n2d-standard-2"
  zone         = "us-east4-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo                        = "bar"
    serial-port-logging-enable = "TRUE"
    enable-oslogin             = "FALSE"
  }


  # service_account {
  #   # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  #   email  = google_service_account.default.email
  #   scopes = ["cloud-platform"]
  # }
}