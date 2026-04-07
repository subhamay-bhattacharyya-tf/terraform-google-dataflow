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

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "kms_key_name" {
  type = string
}
