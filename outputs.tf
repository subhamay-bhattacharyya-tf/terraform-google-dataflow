# ==============================================================================
# Dataflow Job Module - Outputs
# ==============================================================================

output "job_id" {
  description = "The unique ID of the Dataflow job."
  value       = google_dataflow_job.this.id
}

output "job_name" {
  description = "The name of the Dataflow job."
  value       = google_dataflow_job.this.name
}

output "job_state" {
  description = "The current state of the Dataflow job."
  value       = google_dataflow_job.this.state
}

output "job_type" {
  description = "The type of the Dataflow job (JOB_TYPE_BATCH or JOB_TYPE_STREAMING)."
  value       = google_dataflow_job.this.type
}

output "job_project" {
  description = "The GCP project in which the job runs."
  value       = google_dataflow_job.this.project
}

output "job_region" {
  description = "The GCP region in which the job runs."
  value       = google_dataflow_job.this.region
}

output "template_gcs_path" {
  description = "The GCS path of the Dataflow template."
  value       = google_dataflow_job.this.template_gcs_path
}

output "temp_gcs_location" {
  description = "The GCS path used for temporary Dataflow files."
  value       = google_dataflow_job.this.temp_gcs_location
}
