# Terraform Template Specification

Generate these files in the `/` directory:

**main.tf:** _(delegate to `tf-mod-main` skill)_

- Google Dataflow Job using the `google_dataflow_job` resource
- Follow the GCP provider reference and core authoring patterns from the `tf-mod-main` skill

**locals.tf:**

A map type variable must be created from the input variable and the Dataflow job name must be in the following format:

```text
<project_code>-<base_name>-<region>-<environment>
```

**variables.tf:** _(delegate to `tf-mod-vars` skill)_

Use the `tf-mod-vars` skill to author this file. Apply the GCP provider reference and validation patterns. The variable schema is:

| Variable | Type | Required | Notes |
| --- | --- | --- | --- |
| `environment` | `string` | Yes | One of: `devl`, `test`, `prod` |
| `project_code` | `string` | Yes | Short identifier for naming standardization |
| `region` | `string` | No | Default: `us-central1` |
| `dataflow_job_config` | `object` | Yes | See attribute table below |

`dataflow_job_config` attributes:

| Attribute | Type | Required | Default | Validation |
| --- | --- | --- | --- | --- |
| `base_name` | `string` | Yes | — | Alphanumeric or dashes, max length ≤ 30 |
| `template_gcs_path` | `string` | Yes | — | Must start with `gs://` |
| `temp_gcs_location` | `string` | Yes | — | Must start with `gs://` |
| `machine_type` | `string` | No | `n1-standard-2` | Valid Dataflow worker machine type |
| `max_workers` | `number` | No | `1` | Must be >= 1 |
| `network` | `string` | No | `null` | VPC network name or self-link |
| `subnetwork` | `string` | No | `null` | Subnet name or self-link |
| `service_account_email` | `string` | No | `null` | Format: `name@project.iam.gserviceaccount.com` |
| `ip_configuration` | `string` | No | `WORKER_IP_PRIVATE` | One of: `WORKER_IP_PRIVATE`, `WORKER_IP_PUBLIC` |
| `enable_streaming_engine` | `bool` | No | `false` | Enable Streaming Engine for streaming jobs |
| `kms_key_name` | `string` | No | `null` | CMEK key resource name |
| `parameters` | `map(string)` | No | `{}` | Template-specific job parameters |
| `labels` | `map(string)` | No | `{}` | GCP resource labels |
| `additional_experiments` | `list(string)` | No | `[]` | Dataflow experimental features |

**outputs.tf:**

- Outputs for all standard Google Dataflow job attributes:
  - `job_id`
  - `job_name`
  - `job_state`
  - `job_type`
  - `job_project`
  - `job_region`
  - `template_gcs_path`
  - `temp_gcs_location`


**versions.tf:**

- Versions.tf should be in the following format

```hcl

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0"
    }
  }
}

provider "google" {
  region = var.region
}
```

**examples/:** _(delegate to `tf-mod-examples` skill)_

Use the `tf-mod-examples` skill to scaffold the full example matrix. Each example must be a self-contained, independently validatable Terraform configuration under `examples/<name>/` with its own `main.tf`, `variables.tf`, `terraform.tfvars`, and `README.md`.

**test/:**

- `test/dataflow_job_basic_test.go`: This Terratest tests the basic Dataflow job configuration.

**package.json:**

- `github/workflows/ci.yaml`: This is the CI Pipeline. Add all the tests in the terratest job.

Ensure the name is always the repository name.

**package-lock.json:**

Ensure the name is always the repository name.

**CONTRIBUTING.md:**

Ensure in the CONTRIBUTING.md, Reporting Issues must always links to the current repository.

**README.md:** _(delegate to `tf-mod-readme` skill)_

Use the `tf-mod-readme` skill to generate this file. The skill will:

- Auto-resolve the repository name from the current git root
- Check and create the gist badge file if missing
- Populate all badge URLs pointing to the current repository
- Produce terraform-docs-compatible inputs/outputs tables
- Follow markdownlint rules (MD060 table column style)
