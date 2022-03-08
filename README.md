# NewRelic K8s Module

Terraform module for installing/managing NewRelic Kubernetes Agent and corresponding NewRelic resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.newrelic-bundle](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.newrelic-psp](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The cluster name to use in NewRelic. | `string` | n/a | yes |
| <a name="input_license_key"></a> [license\_key](#input\_license\_key) | The NewRelic License Key. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The chart version to be used. Defaults to latest. | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if set to true. | `bool` | `false` | no |
| <a name="input_enable_psp"></a> [enable\_psp](#input\_enable\_psp) | n/a | `bool` | `false` | no |
| <a name="input_low_data_mode"></a> [low\_data\_mode](#input\_low\_data\_mode) | Reduce the amount of data ingested at the cost of dropping detailed information. | `bool` | `false` | no |
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