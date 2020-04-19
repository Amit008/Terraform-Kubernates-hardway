
resource "null_resource" "CA-Resource" {
  # ...

  provisioner "local-exec" {
    command = "../../Scripts/CreateCertificates.sh"
  }
}
