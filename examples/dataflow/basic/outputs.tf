output "job_id" {
  description = "The unique ID of the Dataflow job."
  value       = module.dataflow_job.job_id
}

output "job_name" {
  description = "The name of the Dataflow job."
  value       = module.dataflow_job.job_name
}

output "job_state" {
  description = "The current state of the Dataflow job."
  value       = module.dataflow_job.job_state
}

output "job_type" {
  description = "The type of the Dataflow job."
  value       = module.dataflow_job.job_type
}

output "job_project" {
  description = "The GCP project in which the job runs."
  value       = module.dataflow_job.job_project
}

output "job_region" {
  description = "The GCP region in which the job runs."
  value       = module.dataflow_job.job_region
}

output "template_gcs_path" {
  description = "The GCS path of the Dataflow template."
  value       = module.dataflow_job.template_gcs_path
}

output "temp_gcs_location" {
  description = "The GCS path used for temporary Dataflow files."
  value       = module.dataflow_job.temp_gcs_location
}
