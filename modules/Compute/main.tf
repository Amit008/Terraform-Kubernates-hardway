
resource "google_compute_instance" "Compute-group-0" {
  count=3
  name         = "controller-${count.index}"
  machine_type = "n1-standard-1"
  can_ip_forward   = false
  zone         = "europe-west4-a"
 
  
  tags = ["kubernetes-the-hard-way","controller"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size=200
    }
  }


  network_interface {
    network="${var.network_name}"
    network_ip="10.240.0.1${count.index}"
    subnetwork="${var.subnetwork_name}"

  
  
 access_config {
      // Ephemeral IP
    }
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
  zone         = "europe-west4-a"

  metadata={
    pod-cidr = "10.200.${count.index}.0/24"
    }
  
  tags = ["kubernetes-the-hard-way","controller"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size=200
    }
  }


  network_interface {
    network="${var.network_name}"
    subnetwork="${var.subnetwork_name}"
    network_ip="10.240.0.2${count.index}"

  
  access_config {
      // Ephemeral IP
    }
    }
  
 provisioner "file" {
    source      = "../SystemServices/"
    destination = "/etc/systemd/system/"
  }
  

  
  service_account {
  
    
    
    
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}


#resource "google_compute_route" "kubernetes-route{}" {
#  name        = "network-route"
#  network     = "${var.network_name}"
#  next_hop_ip = "10.240.0.2${count.index}"
#  dest_range  = "10.200.${count.index}.0/24"
#}



