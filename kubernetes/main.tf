module "Setup Network and Reserve External Static IP" {
  source = "./modules/Network"

}

module "Create firewall" {
  source = "./modules/firewall"

}

module "Create Compute Instances" {
  source = "./modules/compute"

}

