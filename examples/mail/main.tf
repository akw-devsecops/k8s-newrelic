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

module "new_relic_agent_mail" {
  source       = "../.."
  cluster_name = "k8s-test-cluster"
  license_key  = "1234abcdNRAL"
  alert_channel_email_config = {
    recipients = "dummy@localhost.com"
  }
}