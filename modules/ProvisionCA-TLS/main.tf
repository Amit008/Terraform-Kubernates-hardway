
resource "ProvisionCA" "CA-Resource" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -initca ca-csr.json | cfssljson -bare ca"
  }
}


resource "Client and Server Certificates" "certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin"
  }
}


resource "Controller Manager Client Certificate" "CM certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager"
  }
}


resource "The Kube Proxy Client Certificate" "Kube-Proxy-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy"
  }
}

resource "The Scheduler Client Certificate" "Schedule-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-scheduler-csr.json | cfssljson -bare kube-scheduler"
  }
}


resource "The Kubernetes API Server Certificate" "The Kube-API-Certificate" {
  # ...

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}


resource "Service Account Key Pair" "Service Account-Certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  service-account-csr.json | cfssljson -bare service-account"
  }
}



