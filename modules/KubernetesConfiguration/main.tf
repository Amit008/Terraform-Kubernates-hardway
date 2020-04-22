
########-----------------------------The kubelet Kubernetes Configuration File-------------------##
resource "null_resource" "Configure-Cluster" {
  # ...
  count =3
  provisioner "local-exec" {
  command ="kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true  --server=https://${var.KUBERNETES_PUBLIC_ADDRESS}:6443 --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-Credentials-Cluster" {
  # ...
depends_on       = ["null_resource.Configure-Cluster"]
  count=3
  
provisioner "local-exec" {
command ="kubectl config set-credentials system:node:worker-${count.index} --client-certificate=../../Certificate/worker-${count.index}.pem --client-key=../../Certificate/worker-${count.index}-key.pem --embed-certs=true  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

resource "null_resource" "Set-Context" {
  # ...
  depends_on       = ["null_resource.Configure-Cluster","null_resource.Set-Credentials-Cluster"]
count=3
provisioner "local-exec" {
command ="kubectl config set-context default --cluster=kubernetes-the-hard-way  --user=system:node:worker-${count.index}  --kubeconfig=../../KubernetesConfig/worker-${count.index}.kubeconfig"
  }
  
 
}

###--------------------------------------The kube-proxy Kubernetes Configuration File---------------------###

resource "null_resource" "Set-kube-proxy-Cluster" {
  # ...
  depends_on = ["null_resource.Set-Context"]
provisioner "local-exec" {
command ="kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true --server=https://${var.KUBERNETES_PUBLIC_ADDRESS}:6443 --kubeconfig=../../KubernetesConfig/kube-proxy.kubeconfig"  
  }
   }

resource "null_resource" "Set-kube-proxy-Credential" {
  # ...
depends_on       = ["null_resource.Set-kube-proxy-Cluster"]
provisioner "local-exec" {
command ="kubectl config set-credentials system:kube-proxy --client-certificate=../../Certificate/kube-proxy.pem --client-key=../../Certificate/kube-proxy-key.pem --embed-certs=true --kubeconfig=../../KubernetesConfig/kube-proxy.kubeconfig"
  }
}

resource "null_resource" "Set-kube-proxy-Context" {
  # ...
depends_on       = ["null_resource.Set-kube-proxy-Cluster"]
provisioner "local-exec" {
command ="kubectl config set-context default --cluster=kubernetes-the-hard-way --user=system:kube-proxy --kubeconfig=../../KubernetesConfig/kube-proxy.kubeconfig"
  }
}


resource "null_resource" "Set-kube-proxy-UserContext" {
  # ...
depends_on       = ["null_resource.Set-kube-proxy-Cluster","null_resource.Set-kube-proxy-Context"]
provisioner "local-exec" {
command ="kubectl config use-context default --kubeconfig=../../KubernetesConfig/kube-proxy.kubeconfig" 
  }
}


##---------------------------------------kubeControllerManager Configuration-----------------##

resource "null_resource" "Set-kubeControllerManager-Cluster" {
  # ...
provisioner "local-exec" {
command ="kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=../../KubernetesConfig/kube-controller-manager.kubeconfig"
  }
  
}

resource "null_resource" "Set-kubeControllerManager-Credential" {
  # ...
  depends_on       = ["null_resource.Set-kubeControllerManager-Cluster"]
provisioner "local-exec" {
command ="kubectl config set-credentials system:kube-controller-manager --client-certificate=../../Certificate/kube-controller-manager.pem --client-key=../../Certificate/kube-controller-manager-key.pem --embed-certs=true --kubeconfig=../../KubernetesConfig/kube-controller-manager.kubeconfig"
  }
  
}

resource "null_resource" "Set-kubeControllerManager-Context" {
  # ...
provisioner "local-exec" {
command ="kubectl config set-context default --cluster=kubernetes-the-hard-way --user=system:kube-controller-manager --kubeconfig=../../KubernetesConfig/kube-controller-manager.kubeconfig"
  }
  
}

resource "null_resource" "Set-kubeControllerManager-userContext" {
  # ...
provisioner "local-exec" {
command ="kubectl config use-context default --kubeconfig=../../KubernetesConfig/kube-controller-manager.kubeconfig"
  }
  
}

###--------------------------------------------Kube Scheduler Config-----------------------##

resource "null_resource" "Set-Scheduler-Cluster" {
  depends_on       = ["null_resource.Set-kubeControllerManager-userContext"]
  # ...
provisioner "local-exec" {
command ="kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=../../KubernetesConfig/kube-scheduler.kubeconfig" 
    }
  
}

resource "null_resource" "Set-Scheduler-Credential" {
  # ...
  depends_on       = ["null_resource.Set-Scheduler-Cluster"]
provisioner "local-exec" {
command ="kubectl config set-credentials system:kube-scheduler --client-certificate=../../Certificate/kube-scheduler.pem --client-key=../../Certificate/kube-scheduler-key.pem --embed-certs=true --kubeconfig=../../KubernetesConfig/kube-scheduler.kubeconfig"
  }
  
}


resource "null_resource" "Set-kubeScheduler-Context" {
  # ...
provisioner "local-exec" {
command ="kubectl config set-context default --cluster=kubernetes-the-hard-way --user=system:kube-scheduler --kubeconfig=../../KubernetesConfig/kube-scheduler.kubeconfig"
  }
  
}


resource "null_resource" "Set-kubeScheduler-User-Context" {
  # ...
  #depends_on       = ["null_resource.Configure-Cluster","null_resource.Set-Credentials-Cluster","null_resource.Set-Context"]
  provisioner "local-exec" {
    command ="kubectl config use-context default --kubeconfig=../../KubernetesConfig/kube-scheduler.kubeconfig" 
    }
  
}
 

#####------------------------The admin Kubernetes Configuration File-----------------------####

resource "null_resource" "Set-kubeAdmin-Cluster" {
  # ...
  depends_on       = ["null_resource.Set-kubeScheduler-User-Context"]
   provisioner "local-exec" {
    command ="kubectl config set-cluster kubernetes-the-hard-way --certificate-authority=../../Certificate/ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=../../KubernetesConfig/admin.kubeconfig" 
    }
  
}
resource "null_resource" "Set-kubeAdmin-Credential" {
  # ...
   depends_on       = ["null_resource.Set-kubeAdmin-Cluster"]
   provisioner "local-exec" {
    command ="kubectl config set-credentials admin --client-certificate=../../Certificate/admin.pem --client-key=../../Certificate/admin-key.pem --embed-certs=true --kubeconfig=../../KubernetesConfig/admin.kubeconfig" 
    }
  
}
resource "null_resource" "Set-kubeAdmin-Context" {
  # ...
   depends_on       = ["null_resource.Set-kubeAdmin-Cluster"]
   provisioner "local-exec" {
    command ="kubectl config set-context default --cluster=kubernetes-the-hard-way --user=admin --kubeconfig=../../KubernetesConfig/admin.kubeconfig" 
    }
  
}
resource "null_resource" "Set-kubeAdmin-User-Context" {
  # ...
  depends_on       = ["null_resource.Set-kubeAdmin-Cluster"]
   provisioner "local-exec" {
    command ="kubectl config use-context default --kubeconfig=../../KubernetesConfig/admin.kubeconfig" 
    }  
}
