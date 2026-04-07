module "dataflow_job" {
  source = "../../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  dataflow_job_config = {
    base_name         = var.base_name
    project_id        = var.project_id
    region            = var.region
    template_gcs_path = var.template_gcs_path
    temp_gcs_location = var.temp_gcs_location
    labels = {
      env         = "devl"
      team        = "data-engineering"
      cost-centre = "platform"
    }
  }
}
