
resource "null_resource" "Configure-Cluster" {
  # ...
  count =3
  provisioner "local-exec" {
    command = "kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig
"
  }
  
 
}


resource "null_resource" "Set-Credentials-Cluster" {
  # ...
count=3
  provisioner "local-exec" {
    command = "kubectl config set-credentials system:node:worker-${count.index} --client-certificate=worker-${count.index}.pem --client-key=worker-${count.index}-key.pem --embed-certs=true  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig
"
  }
  
 
}

resource "null_resource" "Set-Context" {
  # ...
count=3
  provisioner "local-exec" {
    command = " kubectl config set-context default --cluster=kubernetes-the-hard-way  --user=system:node:worker-${count.index}  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-User-Context" {
  # ...
count=3
  provisioner "local-exec" {
    command = " kubectl config use-context default --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"  }
  
}




 
 
