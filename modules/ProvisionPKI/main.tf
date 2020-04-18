
resource "null_resource" "k8" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl -O /opt/download https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson -O /opt/download"
  }
}

resource "null_resource" "k81" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x /opt/download/cfssl /opt/download/cfssljson"
  }
}


resource "null_resource" "k" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x sudo mv /opt/download/cfssl /opt/download/cfssljson /usr/local/bin/"
  }
}

