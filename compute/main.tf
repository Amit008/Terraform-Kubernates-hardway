
resource "google_compute_instance" "default" {
  count=3
  name         = "controller-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-west1-c"

  tags = ["kubernetes-the-hard-way","controller"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    count=3
    subnetwork="kubernetes"
    network_ip=private-network-ip 10.240.0.1${count.index}
    network_tier="STANDARD"

    access_config {
      // Ephemeral IP
    }
  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}
