# Dataflow Job with CMEK Encryption

Demonstrates enabling Customer-Managed Encryption Keys (CMEK) for Dataflow job data at rest. Requires the Dataflow service account to have `roles/cloudkms.cryptoKeyEncrypterDecrypter` on the key.

## Usage

```bash
terraform init -backend=false
terraform validate
```
