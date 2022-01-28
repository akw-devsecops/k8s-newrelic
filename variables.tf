variable "cluster_name" {
  type        = string
  description = "The cluster name to use in NewRelic."
}

variable "license_key" {
  type        = string
  description = "The NewRelic License Key."
}

variable "namespace" {
  type        = string
  default     = "newrelic"
  description = "The namespace in which the bundle will be installed."
}

variable "create_namespace" {
  type        = bool
  default     = false
  description = "Create the namespace if set to true."
}

variable "chart_version" {
  type        = string
  default     = ""
  description = "The chart version to be used. Defaults to latest."
}

variable "privileged" {
  type        = bool
  default     = true
  description = "Set privileged mode. The tradeoff is that the solution will only collect metrics from Kubernetes, but it will not collect any metric from the underlying hosts directly."
}

variable "alert_channel_email_config" {
  type = object({
    recipients = string
  })
  default     = null
  description = "The alert channel email config."
}

variable "alert_channel_webhook_config" {
  type = object({
    base_url = string
  })
  default     = null
  description = "The alert channel webhook config."
}

variable "pixie_enabled" {
  type        = bool
  default     = false
  description = "Set to true to enable instant service-level insights, full-body requests, and application profiles through Pixie (pixie_api_key and pixie_deploy_key will be required)."
}

variable "pixie_api_key" {
  type    = string
  default = "" #tfsec:ignore:general-secrets-sensitive-in-variable
}

variable "pixie_deploy_key" {
  type    = string
  default = ""
}

variable "enable_psp" {
  type    = bool
  default = false
}

variable "additional_alerting_namespaces" {
  type        = list(string)
  description = "Additional namespaces that are included in default alerting."
  default     = []
}
