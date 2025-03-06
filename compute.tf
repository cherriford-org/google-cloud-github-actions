# VM Creation

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

  allow_stopping_for_update = true # Required for several test fields
  can_ip_forward = true

  # First test default = false

  # shielded_instance_config {
  #   enable_secure_boot = true
  # }

  # First test default = false

  # confidential_instance_config {
  #   enable_confidential_compute = false
  # }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  # Defaults to the default service account if omitting email
  service_account {
    scopes = "cloud-platform" # FULL_API_ACCESS
  }

  metadata = {
    foo                        = "bar"
    serial-port-logging-enable = "TRUE"
    enable-oslogin             = "FALSE"
  }
}
