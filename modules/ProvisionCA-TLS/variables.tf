
variable "external_ip" {
type    = "list"
  default = ["0.0.0.0", "0.0.0.1", "0.0.0.2"]
}

variable "internal_ip" {
type    = "list"
  default = ["0.0.0.0", "0.0.0.1", "0.0.0.2"]
}


variable "KUBERNETES_PUBLIC_ADDRESS"{
  }

variable "KUBERNETES_HOSTNAMES" {
  default="kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local"
 }
