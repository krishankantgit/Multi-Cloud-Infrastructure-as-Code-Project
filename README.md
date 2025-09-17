# Multi-Cloud Infrastructure-as-Code Project

Provision and deploy a microservices application across AWS, GCP, and Azure using Terraform (infrastructure), Kubernetes (workloads), and Ansible (post-provision host configuration). Includes a GitHub Actions workflow to run Terraform plans on pull requests and manual applies on demand.

## Tools
- Terraform
- Ansible
- Kubernetes (manifests + Kustomize overlays)
- Docker
- GitHub Actions
- Cloud providers: AWS, GCP, Azure

## Repository Layout
```
terraform/
  envs/
    aws/
    gcp/
    azure/
  modules/
    network/
      aws/
      gcp/
      azure/
ansible/
  inventory.ini
  group_vars/all.yml
  site.yml
k8s/
  base/
  overlays/
    aws/
    gcp/
    azure/
app/
  api/
    Dockerfile
  web/
    Dockerfile
.github/workflows/terraform.yml
```

## High-Level Architecture
- One VPC/VNet per cloud with public/private subnets where applicable.
- Managed K8s optional (EKS/GKE/AKS) or self-managed nodes (stubs here use manifests without managed clusters to keep the sample portable).
- Sample microservices: `api` and `web` deployments exposed via ClusterIP services.
- Cost optimization concepts:
  - Auto scaling groups/node pools
  - Use of spot/preemptible where supported
  - Right-sizing instance types via variables

## Quickstart
1) Set provider credentials locally (AWS/GCP/Azure). For example, ensure AWS credentials are in your environment and GCP/Azure CLIs are logged in.
2) Choose a cloud in `terraform/envs/<cloud>`.
3) Copy `terraform.tfvars.example` to `terraform.tfvars` and adjust values.
4) Initialize and plan:
   ```bash
   cd terraform/envs/aws
   terraform init
   terraform plan -var-file=terraform.tfvars
   ```
5) Apply (optional):
   ```bash
   terraform apply -var-file=terraform.tfvars
   ```
6) Build and push images (or use your registry):
   ```bash
   docker build -t <registry>/mc-api:dev ../../app/api
   docker build -t <registry>/mc-web:dev ../../app/web
   ```
7) Deploy K8s manifests:
   ```bash
   kubectl apply -k k8s/overlays/aws
   ```

## Ansible
Use Ansible for post-provision tasks (installing agents, bootstrap scripts):
```bash
cd ansible
ansible-playbook -i inventory.ini site.yml
```

## CI (GitHub Actions)
- PRs: Terraform fmt/validate/plan
- Manual: `workflow_dispatch` to apply to selected environment with approval
- Images: builds and pushes `mc-api` and `mc-web` to GHCR on pushes to `main`

### Enable GHCR
No extra secrets needed—`GITHUB_TOKEN` is used automatically. In Kubernetes manifests, replace `<registry>` with `ghcr.io/<owner>/<repo>` and tag `latest` or `sha-<commit>`.

## Notes
- This is a scaffold with stubs to adapt for your organization.
- Enable spot/preemptible via variables in `terraform/envs/*/variables.tf`.


