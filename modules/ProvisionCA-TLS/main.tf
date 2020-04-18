
resource "null_resource" "CA-Resource" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -initca ../../JasonFiles/ca-csr.json | cfssljson -bare ca"
  }
}


resource "null_resource" "Client-certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/admin-csr.json | cfssljson -bare admin"
  }
}


resource "null_resource" "CM-certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager"
  }
}


resource "null_resource" "Kube-Proxy-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-proxy-csr.json | cfssljson -bare kube-proxy"
  }
}

resource "null_resource" "Schedule-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/kube-scheduler-csr.json | cfssljson -bare kube-scheduler"
  }
}



resource "null_resource" "Service-Account-Certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=../../Certificate/ca.pem -ca-key=../../Certificate/ca-key.pem -config=../../JasonFiles/ca-config.json -profile=kubernetes ../../JasonFiles/service-account-csr.json | cfssljson -bare service-account"
  }
}



