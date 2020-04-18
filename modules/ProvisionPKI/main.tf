resource "null_resource" "prepare-download" {
  # ...

  provisioner "local-exec" {
    command = "sudo mkdir -p ../../download"
    }
}


resource "null_resource" "download-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo curl -s -L -o ~/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64"
  }
}

resource "null_resource" "download-cfssljson" {
  # ...

  provisioner "local-exec" {
    command = "sudo curl -s -L -o ~/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64"
  }
}


resource "null_resource" "grant-permission-cfssl" {
  # ...

  provisioner "local-exec" {
    command = "sudo chmod +x ~/bin/{cfssl,cfssljson}"
  }
}


resource "null_resource" "setpath" {
  # ...

  provisioner "local-exec" {
    command = "export PATH=$PATH:~/bin"
  }
}

