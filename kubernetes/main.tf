module "SetupNetwork" {
  source = "../modules/Network"

}

module "SetupFirewall" {
  source = "../modules/Firewall"
  network_name="${module.SetupNetwork.Network_Name}"

}

module "SetupComputeInstances" {
  source = "../modules/Compute"
  network_name="${module.SetupNetwork.Network_Name}"
  subnetwork_name="${module.SetupNetwork.SubNetwork_Name}"
}

