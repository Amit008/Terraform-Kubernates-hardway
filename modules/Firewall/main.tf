###Create firewall rules:
resource "google_compute_firewall" "kubernetes-the-hard-way-allow-internal" {
  name    = "kubernetes-the-hard-way-allow-internal"
  network = "${var.network_name}"

  allow {
    protocol = "tcp"
  }
  
  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.240.0.0/24","10.200.0.0/16"]
}

###Create firewall rules
resource "google_compute_firewall" "kubernetes-the-hard-way-allow-external" {
  name    = "kubernetes-the-hard-way-allow-external"
  network = "${var.network_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}





#resource "google_compute_http_health_check" "kubernetes" {
#  name         = "authentication-health-check"
#  host         = "kubernetes.default.svc.cluster.local" 
#  request_path = "/healthz"  
#}



#resource "google_compute_firewall" "kube allow-health-check"
#{
#   name="kubernetes-the-hard-way-allow-health-check"
#   network = "${var.network_name}" 
#   allow {
#    protocol = "tcp"
#  }

 # source_ranges = ["209.85.152.0/22","209.85.204.0/22","35.191.0.0/16"]
 # }


#resource "google_compute_target_pool" "ktPool" {
#  name = "kubernetes-target-pool"
#  instances = [ "controller-0", "controller-1","controller-2"]
#  health_checks = [kubernetes]
#}

#resource "google_compute_forwarding_rule" "kubeforwarding-rule" {
#  name                  = "kubernetes-forwarding-rule"
#  region                = "europe-west4"
#  network               = "${var.network_name}"
#  ports                 = 6443
#  target                = google_compute_target_pool.ktPool.self_link
#subnetwork            = "${google_compute_subnetwork.default.name}"
#}
