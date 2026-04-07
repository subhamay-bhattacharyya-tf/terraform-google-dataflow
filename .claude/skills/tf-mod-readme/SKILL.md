---
name: tf-mod-readme
description: >
  Generates and standardizes README.md files for Terraform modules following
  a consistent structure: title, overview, usage block, requirements,
  inputs/outputs tables, resources, examples, notes/caveats, contributing,
  and license. Use this skill whenever a user asks to create, write, scaffold,
  update, or improve a README for a Terraform module — even if they phrase it
  as "document my module", "add docs to this tf module", "standardize our
  module READMEs", or "what should a Terraform README look like". Also trigger
  when the user shares a .tf file or module directory and asks for
  documentation. Produces terraform-docs-compatible tables and applies
  required/optional/conditional tagging to each section.
disable-model-invocation: true
---

> **Auto-resolve:** Before generating any output, derive `<repository-name>` by running `basename $(git rev-parse --show-toplevel)` in the current working directory. Use the result everywhere `<repository-name>` appears below. Do not prompt the user for it.

> **Gist badge setup:** Before writing the README, check whether the file `<repository-name>.json` exists in gist `476e6e7583432e960e6de16d5223e6a3` by running:
> ```bash
> gh gist view 476e6e7583432e960e6de16d5223e6a3 --files
> ```
> If `<repository-name>.json` is **not listed**, create it by writing a temporary file and adding it to the gist:
> ```bash
> printf '{\n  "schemaVersion": 1,\n  "label": "status",\n  "message": "in progress",\n  "color": "yellow",\n  "style": "flat"\n}' > /tmp/<repository-name>.json
> gh gist edit 476e6e7583432e960e6de16d5223e6a3 --add /tmp/<repository-name>.json
> ```
> Only then proceed to generate the README. The badge URL remains `https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/476e6e7583432e960e6de16d5223e6a3/raw/<repository-name>.json?` regardless.

# terraform-<provider>-<module-name>


![Release](https://github.com/subhamay-bhattacharyya-tf/<repository-name>/actions/workflows/ci.yaml/badge.svg)&nbsp;![GCP](https://img.shields.io/badge/GCP-4285F4?logo=googlecloud&logoColor=white)&nbsp;![Commit Activity](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Last Commit](https://img.shields.io/github/last-commit/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Release Date](https://img.shields.io/github/release-date/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Repo Size](https://img.shields.io/github/repo-size/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![File Count](https://img.shields.io/github/directory-file-count/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Issues](https://img.shields.io/github/issues/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Top Language](https://img.shields.io/github/languages/top/subhamay-bhattacharyya-tf/<repository-name>)&nbsp;![Built with Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-623CE4?logo=anthropic&logoColor=white)&nbsp;![Custom Endpoint](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/476e6e7583432e960e6de16d5223e6a3/raw/<repository-name>.json?)&nbsp;![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.3-blue)&nbsp;![Provider Version](https://img.shields.io/badge/google-%3E%3D7.23-blue)

One-line summary of what this module provisions.

---

## Overview

2–4 sentences describing the purpose of the module, the primary resources it
creates, and the problem it solves. Avoid repeating the title. Focus on the
"why" and what AWS/GCP/Azure resources are managed.

**Example:**
This module creates a production-ready VPC on AWS including public and private
subnets across multiple availability zones. It provisions an Internet Gateway,
NAT Gateways, and route tables following AWS best practices for network
isolation.

---

## Usage

```hcl
module "<module_name>" {
  source  = "org/<module-name>/google"
  version = "~> 1.0"

  environment  = "prod"
  project_code = "myco"
  region       = "us-central1"

  dataflow_job_config = {
    base_name         = "word-count"
    project_id        = "my-gcp-project-123"
    region            = "us-central1"
    template_gcs_path = "gs://dataflow-templates-us-central1/latest/Word_Count"
    temp_gcs_location = "gs://my-project-dataflow-tmp/word-count"

    # Optional
    machine_type     = "n1-standard-4"
    max_workers      = 10
    ip_configuration = "WORKER_IP_PRIVATE"
    labels           = { env = "prod", team = "data-engineering" }
    parameters = {
      inputFile = "gs://dataflow-samples/shakespeare/kinglear.txt"
      output    = "gs://my-project-output/word-count"
    }
  }
}
```

---

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.3.0  |
| google    | >= 7.23.0 |

**Additional prerequisites:**
- GCP credentials with the following permissions: `dataflow.jobs.create`, `storage.objects.get`, `storage.objects.create`
- A GCS bucket for the Dataflow template (`template_gcs_path`)
- A writable GCS bucket for temporary files (`temp_gcs_location`)
- Workload Identity Federation configured for CI (see CI section below)

---

## Inputs

<!-- AUTO-GENERATED by terraform-docs — do not edit manually -->

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Deployment environment | `string` | n/a | **yes** |
| project\_code | Short identifier used in resource naming | `string` | n/a | **yes** |
| region | GCP region for the provider | `string` | `"us-central1"` | no |
| dataflow\_job\_config | Configuration object for the Dataflow job | `object(...)` | n/a | **yes** |

---

## Outputs

<!-- AUTO-GENERATED by terraform-docs — do not edit manually -->

| Name | Description |
|------|-------------|
| job\_id | The unique ID of the Dataflow job |
| job\_name | The name of the Dataflow job |
| job\_state | The current state of the Dataflow job |
| job\_type | The type of the Dataflow job (JOB\_TYPE\_BATCH or JOB\_TYPE\_STREAMING) |
| job\_project | The GCP project in which the job runs |
| job\_region | The GCP region in which the job runs |
| template\_gcs\_path | The GCS path of the Dataflow template |
| temp\_gcs\_location | The GCS path used for temporary Dataflow files |

---

## Resources

| Name | Type |
|------|------|
| [google_dataflow_job.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataflow_job) | resource |

---

## Examples


> Each example is a standalone, runnable Terraform configuration stored in
> `examples/<name>/` with its own `README.md` and terraform validation.

---

## Notes & Caveats

> **Destructive operation:** Destroying this module will cancel the running Dataflow job.
> Ensure all downstream consumers of job outputs are aware before running `terraform destroy`.

- Dataflow jobs are **not idempotent** — each `terraform apply` may submit a new job run if parameters change.
- Use `lifecycle { ignore_changes = [parameters] }` to prevent Terraform from replacing the job on every apply when template parameters are updated at runtime.
- Setting `ip_configuration = "WORKER_IP_PRIVATE"` requires Private Google Access to be enabled on the subnet so workers can reach Google APIs without public IPs.
- `enable_streaming_engine = true` is only applicable to streaming pipelines; setting it on a batch job has no effect.
- CMEK (`kms_key_name`) requires the Dataflow service account to have `roles/cloudkms.cryptoKeyEncrypterDecrypter` on the key.

---

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for full guidelines.

```bash
# Quick start
git clone git@github.com:subhamay-bhattacharyya-tf/<repository-name>.git
cd <repository-name>
terraform fmt -recursive
terraform validate
```

1. Fork the repository and create a feature branch (`git checkout -b feat/my-feature`)
2. Run `terraform fmt`, `terraform validate`, and `terraform-docs .`
3. Add or update tests under `test/` (Terratest)
4. Open a pull request against `main` with a clear description of changes

---

## CI / Workload Identity Federation Setup

The Terratest job authenticates to GCP via [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) (service account impersonation). If the job fails with `Permission 'iam.serviceAccounts.getAccessToken' denied`, grant the WIF pool principal the required IAM binding:

```bash
gcloud iam service-accounts add-iam-policy-binding \
    "<service-account-email>" \
    --project="<gcp-project-id>" \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/projects/<project-number>/locations/global/workloadIdentityPools/<pool-name>/attribute.repository/<github-org>/<repository-name>"
```

The three repository variables required by the CI workflow are:

| Variable | Description |
| --- | --- |
| `GCP_PROJECT_ID` | GCP project ID passed as `GOOGLE_CLOUD_PROJECT` to Terratest |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Full WIF provider resource name |
| `GCP_SERVICE_ACCOUNT` | Service account email to impersonate |

---

## License

MIT © 2026 Your Organization — see [LICENSE](../../../LICENSE) for full terms.
