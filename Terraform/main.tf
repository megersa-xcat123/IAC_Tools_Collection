# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "mega"
  # tenant_name = "ac5fbc4667014e1d9bae0b9fcc98cd24"
  # project_name = "Mega"
  user_domain_name = "Default"
  password    = "otech@2024"
  # auth_url    = "http://172.11.11.8:5000/v3"
  auth_url = "http://cloud.otech.et:5000"
  region      = "RegionOne"
  insecure    = true
}

resource "openstack_compute_instance_v2" "Elasticsearch-VM" {
  name            = "VM-1"
  image_id        = "1c484ac9-7112-437d-9ab3-02e84371a8d7"
  flavor_id       = "3"
  key_pair        = "my-key"
  security_groups = ["Test_SG"]

  network {
    name = "mega_net"
  }
}