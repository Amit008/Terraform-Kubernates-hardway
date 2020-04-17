
resource "google_compute_instance" "Compute-group-0" {
  count=3
  name         = "controller-${count.index}"
  machine_type = "n1-standard-1"
  can_ip_forward   = false
  zone         = "us-west1-c"

  tags = ["kubernetes-the-hard-way","controller"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size=200
    }
  }


  network_interface {
    subnetwork="${var.subnetwork_name}"
    network_ip="10.240.0.1${count.index}"

  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}



resource "google_compute_instance" "Compute-group-1" {
  count=3
  name         = "worker-${count.index}"
  machine_type = "n1-standard-1"
  can_ip_forward   = false
  zone         = "us-west1-c"

  tags = ["kubernetes-the-hard-way","controller"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size=200
    }
  }


  network_interface {
    subnetwork="${subnetwork_name}"
    network_ip="10.240.0.2${count.index}"

  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}
