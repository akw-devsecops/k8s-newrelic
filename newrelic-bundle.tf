resource "helm_release" "newrelic-bundle" {
  name             = "newrelic-bundle"
  repository       = "https://helm-charts.newrelic.com"
  chart            = "nri-bundle"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace

  set_sensitive {
    name  = "global.licenseKey"
    value = var.license_key
  }

  set {
    name  = "global.cluster"
    value = var.cluster_name
  }

  set {
    name  = "global.lowDataMode"
    value = var.low_data_mode
  }

  set {
    name  = "newrelic-infrastructure.privileged"
    value = var.privileged
  }

  set {
    name  = "ksm.enabled"
    value = true
  }

  set {
    name  = "prometheus.enabled"
    value = true
  }

  set {
    name  = "kubeEvents.enabled"
    value = true
  }

  set {
    name  = "newrelic-logging.enabled"
    value = true
  }

  set {
    name  = "newrelic-logging.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "newrelic-pixie.enabled"
    value = var.pixie_enabled
  }

  set_sensitive {
    name  = "newrelic-pixie.apiKey"
    value = var.pixie_api_key
  }

  set {
    name  = "pixie-chart.enabled"
    value = var.pixie_enabled
  }

  set_sensitive {
    name  = "pixie-chart.deployKey"
    value = var.pixie_deploy_key
  }

  set {
    name  = "pixie-chart.clusterName"
    value = var.cluster_name
  }
}
