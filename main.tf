terraform {
  cloud {
    organization = "hc-se-demo-chintan"

    workspaces {
      name = "vault-provider-example"
    }
  }
}


provider "vault" {

    address = "https://vault-cluster-public-vault-0e71c1ed.94ac93b5.z1.hashicorp.cloud:8200"
    namespace = admin
}

data "vault_kv_secret_v2" "example" {
  mount = "kv1"
  name  = "database/dev"
}

output "secret_output" {
  description = "OpenID Claims for trust relationship"
  value       = vault_kv_secret_v2.example.data
}



