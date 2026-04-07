# ==============================================================================
# Dataflow Job Module - Variables
# ==============================================================================

variable "environment" {
  description = "Deployment environment. One of: devl, test, prod."
  type        = string

  validation {
    condition     = contains(["devl", "test", "prod"], var.environment)
    error_message = "environment must be one of: devl, test, prod."
  }
}

variable "project_code" {
  description = "Short identifier used in resource naming standardization."
  type        = string

  validation {
    condition     = length(var.project_code) > 0
    error_message = "project_code must not be empty."
  }
}

variable "region" {
  description = "GCP region for the provider."
  type        = string
  default     = "us-central1"
}

variable "dataflow_job_config" {
  description = "Configuration object for the Google Dataflow job."
  type = object({
    base_name               = string
    project_id              = string
    region                  = optional(string, "us-central1")
    template_gcs_path       = string
    temp_gcs_location       = string
    machine_type            = optional(string, "n1-standard-2")
    max_workers             = optional(number, 1)
    network                 = optional(string, null)
    subnetwork              = optional(string, null)
    service_account_email   = optional(string, null)
    ip_configuration        = optional(string, "WORKER_IP_PRIVATE")
    enable_streaming_engine = optional(bool, false)
    kms_key_name            = optional(string, null)
    parameters              = optional(map(string), {})
    labels                  = optional(map(string), {})
    additional_experiments  = optional(list(string), [])
  })

  validation {
    condition     = length(var.dataflow_job_config.base_name) > 0 && length(var.dataflow_job_config.base_name) <= 30
    error_message = "base_name must be non-empty and at most 30 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.dataflow_job_config.base_name))
    error_message = "base_name must contain only lowercase letters, digits, and hyphens."
  }

  validation {
    condition     = startswith(var.dataflow_job_config.template_gcs_path, "gs://")
    error_message = "template_gcs_path must start with gs://."
  }

  validation {
    condition     = startswith(var.dataflow_job_config.temp_gcs_location, "gs://")
    error_message = "temp_gcs_location must start with gs://."
  }

  validation {
    condition = contains(
      [
        "us-central1", "us-east1", "us-east4", "us-west1", "us-west2",
        "europe-west1", "europe-west2", "europe-west3", "europe-west4",
        "asia-east1", "asia-northeast1", "asia-southeast1", "australia-southeast1"
      ],
      var.dataflow_job_config.region
    )
    error_message = "region must be a valid Dataflow-supported GCP region."
  }

  validation {
    condition     = var.dataflow_job_config.max_workers >= 1
    error_message = "max_workers must be at least 1."
  }

  validation {
    condition     = contains(["WORKER_IP_PRIVATE", "WORKER_IP_PUBLIC"], var.dataflow_job_config.ip_configuration)
    error_message = "ip_configuration must be one of: WORKER_IP_PRIVATE, WORKER_IP_PUBLIC."
  }
}
