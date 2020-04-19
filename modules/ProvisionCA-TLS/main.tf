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

resource "null_resource" "Generate-API-Server-Certificate" {
  # ...
 depends_on       = ["null_resource.Generate-CA"]
  provisioner "local-exec" {
  command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} -profile=kubernetes ../../JasonFiles/kubernetes-csr.json | cfssljson -bare ../../Certificate/kubernetes"
 }
}



