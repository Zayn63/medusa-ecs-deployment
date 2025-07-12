# Medusa Backend Deployment on AWS ECS Fargate

This project demonstrates how to deploy the open-source Medusa backend on AWS ECS using Fargate with Infrastructure as Code (IaC) powered by Terraform. It also includes a GitHub Actions workflow to enable continuous deployment (CD).

##  Architecture Overview

- **ECS Fargate** for serverless container management
- **Application Load Balancer** to route traffic
- **IAM Roles** for ECS task execution
- **Public subnets with VPC module**
- **CI/CD** using GitHub Actions

##  Directory Structure

```bash
.
├── .github/workflows/
│   └── deploy.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── alb.tf
│   ├── iam.tf
├── README.md
```

## 🛠 Setup Instructions

1. **Create a GitHub repo and push these files**.
2. **Add your AWS credentials** to GitHub secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. **Replace the values for** `image_url` and `database_url` using `terraform.tfvars` or environment variables.
4. **Run Terraform**:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

---

© 2025 Junaid Mansuri(zayn). All rights reserved.
