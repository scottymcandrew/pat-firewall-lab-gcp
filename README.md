# GCP PAT Firewall Lab

A Terraform-based lab environment demonstrating **Port Address Translation (PAT)** firewall behaviour in Google Cloud Platform. This lab exposes how internal resources can be reached through port translation — useful for security testing and illustrating how firewalls can bypass Cloud Security Posture (CSP) routing controls.

## Architecture

```
                      Internet
                          │
                    ┌─────┴─────┐
                    │ Public IP │
                    │ :8081     │
                    │ :8082     │
                    └─────┬─────┘
                          │
              ┌───────────┴───────────┐
              │     PAT Firewall      │
              │      (iptables)       │
              │      e2-micro         │
              └───────────┬───────────┘
                    │           │
             nic0   │           │  nic1
          10.1.1.2  │           │  10.1.2.2
                    │           │
          ┌─────────┘           └─────────┐
          │                               │
    ┌─────┴─────┐                   ┌─────┴─────┐
    │   BLUE    │                   │    RED    │
    │  Server   │                   │  Server   │
    │ 10.1.1.3  │                   │ 10.1.2.3  │
    └───────────┘                   └───────────┘
```

## What It Does

| External Port | Translates To | Response |
|---------------|---------------|----------|
| `:8081` | `10.1.1.3:80` | Blue banner |
| `:8082` | `10.1.2.3:80` | Red banner |

The PAT firewall VM uses `iptables` DNAT rules to forward incoming traffic on different ports to separate internal web servers on isolated subnets.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (authenticated)
- A GCP project with Compute Engine API enabled

## Quick Start

```bash
# Clone the repo
git clone https://github.com/scottymcandrew/pat-firewall-lab-gcp.git
cd pat-firewall-lab-gcp

# Configure your project
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and set your project_id

# Deploy
terraform init
terraform apply
```

## Testing

After deployment, Terraform outputs the test URLs:

```bash
# Blue server (via port 8081)
curl http://<EXTERNAL_IP>:8081

# Red server (via port 8082)
curl http://<EXTERNAL_IP>:8082
```

You should see distinct coloured HTML banners confirming which internal server responded.

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `project_id` | *required* | Your GCP project ID |
| `region` | `europe-west2` | GCP region |
| `zone` | `europe-west2-a` | GCP zone |
| `blue_port` | `8081` | External port for blue server |
| `red_port` | `8082` | External port for red server |

## Security Considerations

This lab is intentionally insecure for demonstration purposes:

- SSH is open to `0.0.0.0/0` — restrict `source_ranges` in `firewall.tf` for production
- Web servers have no TLS — this is a lab environment only
- PAT ports are publicly exposed — that's the point!

**Do not use this configuration in production.**

## Cleanup

```bash
terraform destroy
```

## Use Case

This lab demonstrates how PAT firewalls can expose internal resources that might otherwise be hidden behind cloud-native security controls. It's useful for:

- Security testing and penetration testing labs
- Demonstrating firewall bypass techniques
- Training on network address translation concepts
- Validating external scanning tools against known-exposed services

## License

MIT
