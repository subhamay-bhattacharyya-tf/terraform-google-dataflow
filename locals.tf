# ==============================================================================
# Dataflow Job Module - Locals
# ==============================================================================

locals {
  # Job name format: <project_code>-<base_name>-<region>-<environment>
  job_name = "${var.project_code}-${var.dataflow_job_config.base_name}-${var.dataflow_job_config.region}-${var.environment}"
}
