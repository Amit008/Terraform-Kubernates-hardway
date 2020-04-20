
resource "null_resource" "Configure-Cluster" {
  # ...
  count =3
  provisioner "local-exec" {
  command = "kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true  --server=https://${var.KUBERNETES_PUBLIC_ADDRESS}:6443 --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-Credentials-Cluster" {
  # ...
depends_on       = ["Configure-Cluster.id"]
  count=3
  
provisioner "local-exec" {
command = "kubectl config set-credentials system:node:worker-${count.index} --client-certificate=../../Certificate/worker-${count.index}.pem --client-key=../../Certificate/worker-${count.index}-key.pem --embed-certs=true  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-Context" {
  # ...
  depends_on       = ["Configure-Cluster.id","Set-Credentials-Cluster.id"]
count=3
provisioner "local-exec" {
command = " kubectl config set-context default --cluster=kubernetes-the-hard-way  --user=system:node:worker-${count.index}  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-User-Context" {
  # ...
  depends_on       = ["Configure-Cluster.id","Set-Credentials-Cluster.id","Set-Context.id"]
count=3
  provisioner "local-exec" {
    command = " kubectl config use-context default --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig" 
    }
  
}




 
 
