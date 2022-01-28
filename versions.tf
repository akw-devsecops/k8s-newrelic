terraform {
  required_version = ">= 0.13"

  required_providers {
    helm = {
      version = ">= 2.0"
    }
    newrelic = {
      source = "newrelic/newrelic"
      version = ">= 2.24"
    }
  }
}
