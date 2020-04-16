module "Setup Network and Reserve External Static IP" {
  source = "../Network"

}

module "Create firewall" {
  source = "../firewall"

}

module "Create Compute Instances" {
  source = "../compute"

}

