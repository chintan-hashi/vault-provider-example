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
    namespace = "admin"
    token = "hvs.CAESICXEFMUVaT8xvKmO9DZ-Ww4wlYrLjq2wE5qzQaVIB1esGikKImh2cy44cFN2bktWWXRSa2xwcjlXUHhlNjhMYzUuRHM1WU4Q8M-3Aw"
}

data "vault_kv_secret_v2" "example" {
  mount = "kv1"
  name  = "database/dev"
}

output "secret_output_version" {
  description = "secret version"
  value       = data.vault_kv_secret_v2.example.version
}

resource "vault_policy" "example" {
  name = "dev-team"

  policy = <<EOT
path "secret/my_app" {
  capabilities = ["update"]
}
EOT
}

