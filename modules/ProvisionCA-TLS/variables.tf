
variable "external_ip" {

}

variable "internal_ip" {

}

variable "KUBERNETES_HOSTNAMES" {
  default=["kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local"]
 }
