resource "null_resource" "Install-and-start-ETCD" {

  inline = [
      "wget -q --show-progress --https-only --timestamping "https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz",
      "tar -xvf etcd-v3.4.0-linux-amd64.tar.gz",
      "sudo mv etcd-v3.4.0-linux-amd64/etcd* /usr/local/bin/",
      "sudo mkdir -p /etc/etcd /var/lib/etcd",
      "sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/",
      "sudo curl -s -L -o /etc/systemd/system/etcd.service https://github.com/Amit008/Terraform-Kubernates-hardway/blob/master/SystemServices/etcd.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable etcd",
      "sudo systemctl start etcd", 
    ]
  }
