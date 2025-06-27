terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.49.0"
    }
  }
}

provider "openstack" {
  user_name   = “demo-user”
  tenant_name = “demo”
  password    = “demo”
  auth_url    = “OS_AUTH_URL”
  region      = “OS_REGION”
}

resource "openstack_compute_keypair_v2" "demo-keypair" {
  name       = "demo-key"
  public_key = "ssh-rsa ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
}


resource "openstack_networking_network_v2" "demo-network" {
  name           = "demo-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "demo-subnet" {
  network_id = openstack_networking_network_v2.demo-network.id
  name       = "demo-subnet"
  cidr       = "192.168.26.0/24"
}

resource "openstack_networking_router_interface_v2" "demo-router-interface" {
  router_id = “XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX”
  subnet_id = openstack_networking_subnet_v2.demo-subnet.id
}

resource "openstack_compute_instance_v2" "demo-instance" {
  name            = "demo"
  image_id        = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
  flavor_id       = "3"
  key_pair        = "demo-key"
  security_groups = ["default"]

  metadata = {
    this = "that"
  }

  network {
    name = "demo-network"
  }
}