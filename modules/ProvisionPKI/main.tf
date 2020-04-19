resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo curl -s -L -o /usr/local/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "download-cfssljson" {
  # ...

  provisioner "local-exec" {
    command = "sudo curl -s -L -o /usr/local/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64"
    interpreter = ["/bin/bash", "-c"]
  }
}



resource "null_resource" "grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod 775 /usr/local/bin/cfssl"
    interpreter = ["/bin/bash", "-c"]
  }
}


resource "null_resource" "setpath" {
  # ...

  provisioner "local-exec" {
    command = "export PATH=$PATH:/usr/local/bin"
    interpreter = ["/bin/bash", "-c"]
  }
}
