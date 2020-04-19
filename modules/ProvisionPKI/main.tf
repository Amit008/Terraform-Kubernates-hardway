resource "null_resource" "Install-cfssl" {
 provisioner "local-exec" {
    command = "sudo curl -s -L -o /usr/local/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64"
  }
}


resource "null_resource" "Install-cfssl-json" {
 depends_on = ["null_resource.Install-cfssl.id"] 
 provisioner "local-exec" {
    command = "sudo curl -s -L -o /usr/local/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64"
  }
}


resource "null_resource" "Grant-permission-script" {
  depends_on = ["null_resource.Install-cfssl.id","null_resource.Install-cfssl-json.id"] 
  provisioner "local-exec" {
    command = "sudo chmod 775 /usr/local/bin/cfssl*"
  }
}
