# NewRelic K8s Module

Terraform module for installing/managing NewRelic Kubernetes Agent and corresponding NewRelic resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 2.24 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 2.24 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.newrelic-bundle](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.newrelic-psp](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [newrelic_alert_channel.kubernetes_email_alert_channel](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_channel) | resource |
| [newrelic_alert_channel.kubernetes_webhook_alert_channel](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_channel) | resource |
| [newrelic_alert_policy.kubernetes-alerts](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_nrql_alert_condition.cluster-does-not-response](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.container-cpu-high](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.container-memory-high](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.container-out-of-space](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.node-cpu-high](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.node-memory-high](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.node-pod-high](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.pod-not-ready](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.replicaset-not-desired-amount](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The cluster name to use in NewRelic. | `string` | n/a | yes |
| <a name="input_license_key"></a> [license\_key](#input\_license\_key) | The NewRelic License Key. | `string` | n/a | yes |
| <a name="input_additional_alerting_namespaces"></a> [additional\_alerting\_namespaces](#input\_additional\_alerting\_namespaces) | Additional namespaces that are included in default alerting. | `list(string)` | `[]` | no |
| <a name="input_alert_channel_email_config"></a> [alert\_channel\_email\_config](#input\_alert\_channel\_email\_config) | The alert channel email config. | <pre>object({<br>    recipients = string<br>  })</pre> | `null` | no |
| <a name="input_alert_channel_webhook_config"></a> [alert\_channel\_webhook\_config](#input\_alert\_channel\_webhook\_config) | The alert channel webhook config. | <pre>object({<br>    base_url = string<br>  })</pre> | `null` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The chart version to be used. Defaults to latest. | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if set to true. | `bool` | `false` | no |
| <a name="input_enable_psp"></a> [enable\_psp](#input\_enable\_psp) | n/a | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace in which the bundle will be installed. | `string` | `"newrelic"` | no |
| <a name="input_pixie_api_key"></a> [pixie\_api\_key](#input\_pixie\_api\_key) | n/a | `string` | `""` | no |
| <a name="input_pixie_deploy_key"></a> [pixie\_deploy\_key](#input\_pixie\_deploy\_key) | n/a | `string` | `""` | no |
| <a name="input_pixie_enabled"></a> [pixie\_enabled](#input\_pixie\_enabled) | Set to true to enable instant service-level insights, full-body requests, and application profiles through Pixie (pixie\_api\_key and pixie\_deploy\_key will be required). | `bool` | `false` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | Set privileged mode. The tradeoff is that the solution will only collect metrics from Kubernetes, but it will not collect any metric from the underlying hosts directly. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Docs

To update the docs just run
```shell
$ terraform-docs .
```