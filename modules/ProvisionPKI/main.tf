
resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl -O /opt/download/cfssl"
  }
}

resource "null_resource" "download-cfssljson" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson -O /opt/download/cfssljson"
  }
}


resource "null_resource" "grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x /opt/download/*"
  }
}


resource "null_resource" "move-to-bin" {
  # ...

  provisioner "local-exec" {
    command = "sudo mv /opt/download/* /usr/local/bin/"
  }
}

