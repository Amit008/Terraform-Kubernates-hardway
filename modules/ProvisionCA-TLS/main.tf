
resource "null_resource" "CA-Resource" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -initca ca-csr.json | cfssljson -bare ca"
  }
}


resource "null_resource" "Client-certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin"
  }
}


resource "null_resource" "CM certificates" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager"
  }
}


resource "null_resource" "Kube-Proxy-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy"
  }
}

resource "null_resource" "Schedule-certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-scheduler-csr.json | cfssljson -bare kube-scheduler"
  }
}


resource "null_resource" "The Kube-API-Certificate" {
  # ...

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}


resource "null_resource" "Service Account-Certificate" {
  # ...

  provisioner "local-exec" {
    command = "cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes service-account-csr.json | cfssljson -bare service-account"
  }
}



