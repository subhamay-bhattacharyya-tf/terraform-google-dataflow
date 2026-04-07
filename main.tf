# ==============================================================================
# Dataflow Job Module - Main
# Creates and manages a Google Dataflow job.
# ==============================================================================

resource "google_dataflow_job" "this" {
  name              = local.job_name
  project           = var.dataflow_job_config.project_id
  region            = var.dataflow_job_config.region
  template_gcs_path = var.dataflow_job_config.template_gcs_path
  temp_gcs_location = var.dataflow_job_config.temp_gcs_location

  # Worker configuration
  machine_type = var.dataflow_job_config.machine_type
  max_workers  = var.dataflow_job_config.max_workers

  # Networking
  network    = var.dataflow_job_config.network
  subnetwork = var.dataflow_job_config.subnetwork

  # Identity and access
  service_account_email = var.dataflow_job_config.service_account_email
  ip_configuration      = var.dataflow_job_config.ip_configuration

  # Streaming Engine — only meaningful for streaming pipelines
  enable_streaming_engine = var.dataflow_job_config.enable_streaming_engine

  # CMEK encryption
  kms_key_name = var.dataflow_job_config.kms_key_name

  # Template-specific parameters
  parameters = var.dataflow_job_config.parameters

  # Resource labels
  labels = var.dataflow_job_config.labels

  # Experimental Dataflow features
  additional_experiments = var.dataflow_job_config.additional_experiments

  lifecycle {
    # Dataflow re-evaluates parameters on every plan; ignore drift to prevent
    # spurious job replacements when template parameters change at runtime.
    ignore_changes = [parameters]
  }
}
