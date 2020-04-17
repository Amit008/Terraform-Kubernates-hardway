
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
yum install -y update all
yum install -y install socat conntrack ipset

wget -q --show-progress --https-only --timestamping \
  https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.15.0/crictl-v1.15.0-linux-amd64.tar.gz \
  https://github.com/opencontainers/runc/releases/download/v1.0.0-rc8/runc.amd64 \
  https://github.com/containernetworking/plugins/releases/download/v0.8.2/cni-plugins-linux-amd64-v0.8.2.tgz \
  https://github.com/containerd/containerd/releases/download/v1.2.9/containerd-1.2.9.linux-amd64.tar.gz \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubelet

sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes

mkdir containerd
  tar -xvf crictl-v1.15.0-linux-amd64.tar.gz
  tar -xvf containerd-1.2.9.linux-amd64.tar.gz -C containerd
  sudo tar -xvf cni-plugins-linux-amd64-v0.8.2.tgz -C /opt/cni/bin/
  sudo mv runc.amd64 runc
  chmod +x crictl kubectl kube-proxy kubelet runc 
  sudo mv crictl kubectl kube-proxy kubelet runc /usr/local/bin/
  sudo mv containerd/bin/* /bin/


EOH
  }
  
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}
