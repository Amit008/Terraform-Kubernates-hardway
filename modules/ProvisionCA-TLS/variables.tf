
variable "external_ip" {
type    = "list"
}

variable "internal_ip" {
type    = "list"
}


variable "KUBERNETES_PUBLIC_ADDRESS"{
  }

variable "KUBERNETES_HOSTNAMES" {
  default="kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local"
 }
