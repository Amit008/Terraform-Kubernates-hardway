resource "null_resource" "Grant-permission=script" {
  # ...

  provisioner "local-exec" {
    command = "chmod 775 ../../Scripts/CreateCertificates.sh"
  }
}

resource "null_resource" "CA-Resource" {
  # ...

  provisioner "local-exec" {
    command = "../../Scripts/CreateCertificates.sh"
  }
}
