resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "../../Scripts/cfssl_Installation.sh"
    interpreter = ["/bin/bash", "-c"]
  }
}
