module "new_relic_agent" {
  source       = "../.."
  cluster_name = "k8s-test-cluster"
  license_key  = "1234abcdNRAL"
  enable_psp   = true
}
