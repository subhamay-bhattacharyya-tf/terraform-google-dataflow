# Dataflow Job with Private IP Workers

Demonstrates running Dataflow workers with internal IPs only. Requires Private Google Access enabled on the subnet so workers can reach Google APIs without public IPs.

## Usage

```bash
terraform init -backend=false
terraform validate
```
