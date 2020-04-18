resource "null_resource" "prepare-download" {
  # ...

  provisioner "local-exec" {
    command = "sudo mkdir -p ../../download"
    }
}


resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl -O ../../download/cfssl"
  }
}

resource "null_resource" "download-cfssljson" {
  # ...

  provisioner "local-exec" {
    command = "wget -q --show-progress --https-only --timestamping https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson -O ../../download/cfssljson"
  }
}


resource "null_resource" "grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x ../../download/*"
  }
}


resource "null_resource" "move-to-bin" {
  # ...

  provisioner "local-exec" {
    command = "sudo mv ../../download/* /usr/local/bin"
  }
}

