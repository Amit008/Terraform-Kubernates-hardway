
resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl -O /opt/download/cfssl https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson -O /opt/download/cfssljson"
  }
}

resource "null_resource" "grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x /opt/download/cfssl /opt/download/cfssljson"
  }
}


resource "null_resource" "move-to-bin" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x sudo mv /opt/download/cfssl /opt/download/cfssljson /usr/local/bin/"
  }
}

