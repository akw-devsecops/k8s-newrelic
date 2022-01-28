resource "helm_release" "newrelic-psp" {
  count            = var.enable_psp ? 1 : 0
  name             = "newrelic-psp"
  chart            = "${path.module}/chart/pod-security-policy"
  namespace        = var.namespace
  create_namespace = var.create_namespace
}
