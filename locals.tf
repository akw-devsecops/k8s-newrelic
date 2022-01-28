locals {
  namespaces_all = concat(["default", "kube-public", "kube-system", var.namespace], var.additional_alerting_namespaces)
  namespaces_quoted = formatlist("'%s'", local.namespaces_all)
  namespaces_joined = join(", ", local.namespaces_quoted)
}