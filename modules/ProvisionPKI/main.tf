resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "chmod 775 ../../Scripts/cfssl_Installation.sh"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "../../Scripts/cfssl_Installation.sh"
    interpreter = ["/bin/bash", "-c"]
  }
}
