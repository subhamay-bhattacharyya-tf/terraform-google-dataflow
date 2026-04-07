---
name: tf-mod-examples
description: >
  Generates Terraform module example configurations covering all meaningful
  combinations of input variables. Use this skill when the user asks to
  generate examples, scaffold example directories, create tfvars combinations,
  or produce a complete examples/ folder for a Terraform module. Trigger when
  the user says "generate all examples", "scaffold examples", "create example
  combinations", or "fill in the examples directory". Also trigger when the
  user shares a variables.tf and asks for example usage across all options.
---

# Terraform Module Examples — Generator Skill

This skill generates a complete `examples/` directory tree for a Terraform
module by reading `variables.tf` and producing one standalone example per
meaningful feature combination.

---

## How to Use This Skill

1. Read `variables.tf` (and `versions.tf` if present) from the current module root.
2. Identify every optional field and enumerate its allowed values from `validation` blocks or type annotations.
3. Derive the example matrix using the rules below.
4. Write each example as a self-contained directory under `examples/` with its own `main.tf`, `variables.tf`, `terraform.tfvars`, and `README.md`.

---

## Step 1 — Enumerate Axes

For each optional field in the root `dataflow_job_config` object, record:

| Axis | Values |
|---|---|
| `machine_type` | `n1-standard-2`, `n1-standard-4`, `n1-highmem-4`, `n2-standard-4` |
| `max_workers` | `1`, `5`, `10`, `20` |
| `num_workers` | `null` (auto), `1`, `3` |
| `ip_configuration` | `WORKER_IP_PRIVATE`, `WORKER_IP_PUBLIC` |
| `enable_streaming_engine` | `true`, `false` |
| `network` / `subnetwork` | absent, present |
| `service_account_email` | absent, present |
| `kms_key_name` | absent, present (placeholder) |
| `parameters` | absent, present (template-specific key/value pairs) |
| `labels` | absent, present |
| `additional_experiments` | absent, present |

---

## Step 2 — Example Matrix

Do **not** generate the full cartesian product. Instead produce these named
examples, each exercising a distinct capability or realistic deployment pattern:

| Directory | Purpose | Key axes exercised |
|---|---|---|
| `basic/` | Minimal required fields only | defaults everywhere |
| `with-custom-machine-type/` | Worker sizing for CPU-intensive pipelines | `machine_type=n1-highmem-4`, `num_workers=3`, `max_workers=10` |
| `with-max-workers/` | Autoscaling ceiling | `max_workers=20` |
| `with-private-ip/` | VPC-private workers (no public IPs) | `ip_configuration=WORKER_IP_PRIVATE`, `network`, `subnetwork` |
| `with-streaming-engine/` | Streaming pipeline with Streaming Engine | `enable_streaming_engine=true` |
| `with-kms/` | CMEK encryption for job data | `kms_key_name` placeholder |
| `with-labels/` | Resource labelling | `labels` map with env/team/cost-centre |
| `with-service-account/` | Custom worker service account | `service_account_email` placeholder |
| `with-parameters/` | Template-specific pipeline parameters | `parameters` map with sample key/value pairs |
| `with-experiments/` | Dataflow experimental features | `additional_experiments` list |
| `complete/` | All features on | private-ip, streaming-engine, kms, labels, service-account, parameters, experiments |

---

## Step 3 — File Structure per Example

Each example directory must contain exactly these four files:

```
examples/<name>/
├── main.tf            # module call block only — no provider block
├── variables.tf       # re-declare only the variables consumed in main.tf
├── terraform.tfvars   # concrete values for every variable in variables.tf
└── README.md          # one-paragraph description + usage snippet
```

### `main.tf` template

```hcl
module "<name>" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  dataflow_job_config = {
    base_name         = var.base_name
    template_gcs_path = var.template_gcs_path
    temp_gcs_location = var.temp_gcs_location
    # ... only include fields relevant to this example
  }
}
```

### `variables.tf` template

```hcl
variable "environment"       { type = string }
variable "project_code"      { type = string }
variable "region"            { type = string  default = "us-central1" }
variable "base_name"         { type = string }
variable "template_gcs_path" { type = string }
variable "temp_gcs_location" { type = string }
```

### `terraform.tfvars` template

```hcl
environment       = "devl"
project_code      = "demo"
region            = "us-central1"
base_name         = "<example-slug>"
template_gcs_path = "gs://dataflow-templates-us-central1/latest/Word_Count"
temp_gcs_location = "gs://<your-bucket>/tmp"
```

### `README.md` template

```markdown
# <Example Title>

One sentence describing what this example demonstrates.

## Usage

\`\`\`bash
terraform init -backend=false
terraform validate
\`\`\`
```

---

## Step 4 — Validation Rules

After writing all files:

1. Run `terraform fmt -recursive examples/` to format all generated files.
2. Run `terraform init -backend=false && terraform validate` inside each example directory and report any errors.
3. Fix any errors before returning.

---

## Step 5 — Output Summary

After all files are written and validated, print a table:

| Example | Files written | Validated |
|---|---|---|
| `basic/` | 4 | ✓ |
| ... | ... | ... |
