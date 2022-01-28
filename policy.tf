resource "newrelic_alert_policy" "kubernetes-alerts" {
  name                = "${var.cluster_name} default alert policy"
  incident_preference = "PER_CONDITION_AND_TARGET"

  channel_ids = (
    length(newrelic_alert_channel.kubernetes_email_alert_channel) != 0
    ? [newrelic_alert_channel.kubernetes_email_alert_channel.0.id]
    : (
      length(newrelic_alert_channel.kubernetes_webhook_alert_channel) != 0
      ? [newrelic_alert_channel.kubernetes_webhook_alert_channel.0.id]
      : []
    )
  )
}

resource "newrelic_nrql_alert_condition" "cluster-does-not-response" {
  name                           = "Cluster doesn't response"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sClusterSample SELECT count(*) WHERE clusterName = '${var.cluster_name}'"
  }

  critical {
    operator              = "below"
    threshold             = 1
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "node-cpu-high" {
  name                         = "Node allocatable CPU utilization % is too high"
  policy_id                    = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds = 86400
  value_function               = "single_value"
  aggregation_method           = "event_timer"

  nrql {
    query = "FROM K8sNodeSample SELECT average(cpuUsedCores/capacityCpuCores*100) WHERE clusterName = '${var.cluster_name}' FACET nodeName"
  }

  critical {
    operator              = "above"
    threshold             = 95
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  warning {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "node-memory-high" {
  name                         = "Node allocatable memory utilization % is too high"
  policy_id                    = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds = 86400
  value_function               = "single_value"
  aggregation_method           = "event_timer"

  nrql {
    query = "FROM K8sNodeSample SELECT average(memoryWorkingSetBytes/capacityMemoryBytes*100) WHERE clusterName = '${var.cluster_name}' FACET nodeName"
  }

  critical {
    operator              = "above"
    threshold             = 95
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  warning {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "node-pod-high" {
  name                         = "Node pods allocatable utilization % is too high"
  policy_id                    = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds = 86400
  value_function               = "single_value"
  aggregation_method           = "event_timer"

  nrql {
    query = "FROM K8sPodSample SELECT latest(isScheduled) WHERE clusterName = '${var.cluster_name}' FACET podName"
  }

  critical {
    operator              = "equals"
    threshold             = 0
    threshold_duration    = 420
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "container-cpu-high" {
  name                           = "Container CPU usage % is too high"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sContainerSample SELECT average(cpuCoresUtilization) WHERE clusterName = '${var.cluster_name}' AND namespace IN (${local.namespaces_joined}) FACET containerName"
  }

  critical {
    operator              = "above"
    threshold             = 95
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  warning {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "container-memory-high" {
  name                           = "Container memory usage % is too high"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sContainerSample SELECT average(memoryWorkingSetUtilization) WHERE clusterName = '${var.cluster_name}' AND namespace IN (${local.namespaces_joined}) FACET containerName"
  }

  critical {
    operator              = "above"
    threshold             = 95
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  warning {
    operator              = "above"
    threshold             = 85
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "pod-not-ready" {
  name                           = "Pod is not ready"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sPodSample SELECT latest(isReady) WHERE clusterName = '${var.cluster_name}' AND namespace IN (${local.namespaces_joined}) AND status != 'Succeeded' AND createdKind != 'Job' FACET podName"
  }

  critical {
    operator              = "equals"
    threshold             = 0
    threshold_duration    = 600
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "container-out-of-space" {
  name                           = "Container is running out of space"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sContainerSample SELECT average(fsUsedPercent) WHERE clusterName = '${var.cluster_name}' AND namespace IN (${local.namespaces_joined}) FACET containerName"
  }

  critical {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  warning {
    operator              = "above"
    threshold             = 75
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "replicaset-not-desired-amount" {
  name                           = "ReplicaSet doesn't have desired amount of pods"
  policy_id                      = newrelic_alert_policy.kubernetes-alerts.id
  violation_time_limit_seconds   = 86400
  value_function                 = "single_value"
  expiration_duration            = 300
  close_violations_on_expiration = true
  aggregation_method             = "event_timer"

  nrql {
    query = "FROM K8sReplicasetSample SELECT latest(podsDesired - podsReady) WHERE clusterName = '${var.cluster_name}' AND namespace IN (${local.namespaces_joined}) FACET replicasetName"
  }

  critical {
    operator              = "above"
    threshold             = 0
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}
