resource "null_resource" "Generate-CA" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -initca ../../JasonFiles/ca-csr.json | cfssljson -bare ../../Certificate/ca"
  }
}

resource "null_resource" "Generate-Admin-certificate" {
  # ...
 depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/admin-csr.json | cfssljson -bare ../../Certificate/admin"
  }
}


resource "null_resource" "Generate-Kube-Controller" {
  # ...
  depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/admin-csr.json | cfssljson -bare ../../Certificate/admin"
  }
}


resource "null_resource" "Generate-Kube-Proxy" {
  # ...
  depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-proxy-csr.json | cfssljson -bare ../../Certificate/kube-proxy"

 }
}


resource "null_resource" "Generate-Kube-Scheduler" {
  # ...
  depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem  -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-scheduler-csr.json | cfssljson -bare ../../Certificate/kube-scheduler"

 }
}


resource "null_resource" "Generate-Service-account" {
  # ...
 depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
  command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/service-account-csr.json | cfssljson -bare ../../Certificate/service-account"

 }
}
