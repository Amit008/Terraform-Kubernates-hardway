
resource "google_compute_instance" "Install-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl -O /opt/download https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson -O /opt/download"
  }
}

resource "google_compute_instance" "Grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x /opt/download/cfssl /opt/download/cfssljson"
  }
}


resource "google_compute_instance" "cfssl-move-bin" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x sudo mv /opt/download/cfssl /opt/download/cfssljson /usr/local/bin/"
  }
}
