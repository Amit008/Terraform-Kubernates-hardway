
resource "google_compute_instance" "default" {
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
    count=3
    subnetwork="kubernetes"
    network_ip=10.240.0.1${count.index}
    network_tier="STANDARD"

  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}



resource "google_compute_instance" "default" {
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
    count=3
    subnetwork="kubernetes"
    network_ip=10.240.0.2${count.index}
    network_tier="STANDARD"

  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}
