
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

  }
  
 
  provisioner "local-exec" {
    command = <<EOH
wget -q --show-progress --https-only --timestamping https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz
tar -xvf etcd-v3.4.0-linux-amd64.tar.gz
sudo mv etcd-v3.4.0-linux-amd64/etcd* /usr/local/bin/
 mkdir -p /etc/etcd /var/lib/etcd
 cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
INTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)
ETCD_NAME=$(hostname -s)
wget -q --show-progress --https-only --timestamping https://github.com/Amit008/Terraform-Kubernates-hardway/blob/master/SystemServices/etcd.service
mv etcd.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable etcd
systemctl start etcd

wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl"

chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
 mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/

mkdir -p /var/lib/kubernetes/

EOH
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

  }
  
  provisioner "local-exec" {
    command = <<EOH
wget -q --show-progress --https-only --timestamping https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz
tar -xvf etcd-v3.4.0-linux-amd64.tar.gz
sudo mv etcd-v3.4.0-linux-amd64/etcd* /usr/local/bin/



EOH
  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}
