module "dataflow_job" {
  source = "../../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  dataflow_job_config = {
    base_name               = var.base_name
    project_id              = var.project_id
    region                  = var.region
    template_gcs_path       = var.template_gcs_path
    temp_gcs_location       = var.temp_gcs_location
    machine_type            = "n1-standard-4"
    max_workers             = 10
    ip_configuration        = "WORKER_IP_PRIVATE"
    network                 = var.network
    subnetwork              = var.subnetwork
    service_account_email   = var.service_account_email
    enable_streaming_engine = true
    kms_key_name            = var.kms_key_name
    additional_experiments  = ["enable_stackdriver_agent_metrics", "use_runner_v2"]
    labels = {
      env         = "devl"
      team        = "data-engineering"
      cost-centre = "platform"
    }
    parameters = {
      inputSubscription = "projects/prj-11-dataflow-16748/subscriptions/my-subscription"
      outputTableSpec   = "prj-11-dataflow-16748:my_dataset.my_table"
    }
  }
}
