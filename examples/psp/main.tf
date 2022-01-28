terraform {
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  account_id = 123456
  region     = "US"
  api_key    = "1234abcd"
}

module "new_relic_agent" {
  source       = "../.."
  cluster_name = "k8s-test-cluster"
  license_key  = "1234abcdNRAL"
  enable_psp   = true
}
