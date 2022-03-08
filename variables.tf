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

variable "low_data_mode" {
  type        = bool
  default     = false
  description = "Reduce the amount of data ingested at the cost of dropping detailed information."
}

variable "privileged" {
  type        = bool
  default     = true
  description = "Set privileged mode. The tradeoff is that the solution will only collect metrics from Kubernetes, but it will not collect any metric from the underlying hosts directly."
}

variable "pixie_enabled" {
  type        = bool
  default     = false
  description = "Set to true to enable instant service-level insights, full-body requests, and application profiles through Pixie (pixie_api_key and pixie_deploy_key will be required)."
}

variable "pixie_api_key" {
  type    = string
  default = ""
}

variable "pixie_deploy_key" {
  type    = string
  default = ""
}

variable "enable_psp" {
  type    = bool
  default = false
}
