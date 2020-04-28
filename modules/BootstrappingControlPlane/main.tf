
resource "null_resource" "Install-configure-controlplane" {
 provisioner "remote-exec" {
    inline = [
wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl",

"chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl",
"sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/",
"sudo mkdir -p /var/lib/kubernetes/",
"sudo mv ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem service-account-key.pem service-account.pem encryption-config.yaml /var/lib/kubernetes/",
     
      ]
   }
  
  }

resource "null_resource" "Install-configure-kube-apiserver" {
 provisioner "remote-exec" {
    inline = [
  "sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/",
  "sudo curl -s -L -o /etc/systemd/system/kube-apiserver.service https://github.com/Amit008/Terraform-Kubernates-hardway/blob/master/SystemServices/kube-apiserver.service",    
  "sudo systemctl daemon-reload",
  "sudo systemctl enable kube-apiserver"
  "sudo systemctl start kube-apiserver"
      
]
   }
  }

resource "null_resource" "Install-configure-ControllerManager" {
 provisioner "remote-exec" {
    inline = [
     "sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/",
      "sudo curl -s -L -o /etc/systemd/system/kube-controller-manager.service https://github.com/Amit008/Terraform-Kubernates-hardway/blob/master/SystemServices/kube-controller-manager.service",
      
  "sudo systemctl daemon-reload",
  "sudo systemctl enable kube-controller-manager"
  "sudo systemctl start kube-controller-manager"      
]
   }
  }


resource "null_resource" "Install-configure-kube-scheduler" {
 provisioner "remote-exec" {
    inline = [
  "sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/",
  "sudo curl -s -L -o /etc/systemd/system/kube-controller-manager.service https://github.com/Amit008/Terraform-Kubernates-hardway/blob/master/SystemServices/kube-scheduler.service",    
  "sudo systemctl daemon-reload",
  "sudo systemctl enable kube-scheduler"
  "sudo systemctl start kube-scheduler"      
]
   }
  }




