module "SetupNetwork" {
  source = "../modules/Network"

}

module "SetupFirewall" {
  source = "../modules/Firewall"

}

module "SetupComputeInstances" {
  source = "../modules/Compute"

}

