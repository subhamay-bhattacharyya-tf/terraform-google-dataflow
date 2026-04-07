variable "environment" {
  type = string
}

variable "project_code" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "base_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "template_gcs_path" {
  type = string
}

variable "temp_gcs_location" {
  type = string
}

variable "service_account_email" {
  description = "Service account email for Dataflow workers. Defaults to the Compute Engine default SA when null."
  type        = string
  default     = null
}
