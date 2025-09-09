Project 2: Secure Application Infrastructure Deployment on AWS using Terraform
Objective:Deploy and manage a secure, scalable application infrastructure on AWS using Terraform, leveraging the VPC created in Project 1.
Key Highlights:
* Provision core AWS services:
    * EC2 Instances (Auto Scaling enabled). 
    * Elastic Load Balancer (ALB/NLB) for traffic distribution.
    * S3 Buckets with encryption, versioning, and lifecycle policies.
    * CloudFront for CDN and caching.
    * Route 53 for domain name management.
    * RDS (Multi-AZ, encrypted at rest & transit).
    * AWS Secrets Manager to securely store and retrieve credentials (DB password, API keys).
* Integrate Terraform remote state from Project 1 to reference VPC, subnets, and security groups.
* Implement high security standards:
    * IAM roles with least privilege.
    * EC2 instances without hardcoded secrets (all retrieved from AWS Secrets Manager).
    * HTTPS-enabled communication through SSL/TLS certificates.
    * Private subnets for RDS and application servers, public subnets only for load balancers.
* Support multi-environment deployment (Dev, QA, Production) with separate configurations and workspaces.
* Infrastructure designed to be scalable, fault-tolerant, and production-ready.



## **Project Architecture**

### **Core AWS Services**
| Component | Description |
|-----------|-------------|
| VPC | Isolated network environment for all project resources. |
| Subnets | Public & private subnets across availability zones for HA. |
| Internet Gateway & NAT | Internet access for public/private subnets. |
| EC2 Instances | Application servers running in private subnets. |
| RDS MySQL | Managed database instance with encryption & subnet group. |
| S3 Bucket | Storage for static content with encryption, versioning, and access control. |
| ALB | Application Load Balancer for traffic distribution. |
| CloudFront | CDN for fast content delivery from S3. |
| Route53 | DNS hosting for application domain. |
| Secrets Manager | Secure storage of DB credentials. |

---

### **Environment Support**
- **Dev**: `envs/dev/dev.tfvars`
- **QA**: `envs/qa/qa.tfvars`
- **Prod**: `envs/prod/prod.tfvars`

Each environment has its own Terraform variables and backend configuration, enabling isolated deployments.

---

## **Project Structure**
project2/
├── backend.tf
├── data.tf
├── envs/
│ ├── dev/
│ │ ├── backend.hcl
│ │ └── dev.tfvars
│ ├── qa/
│ │ └── qa.tfvars
│ └── prod/
│ └── prod.tfvars
├── main.tf
├── modules/
│ ├── alb/
│ ├── cloudfront/
│ ├── ec2/
│ ├── iam/
│ ├── rds/
│ ├── route53/
│ ├── s3/
│ └── secrets_manager/
├── outputs.tf
├── provider.tf
├── README.md
├── terraform.tfvars
└── variables.tf


---

## **Terraform Workflow**

### **1. Initialize Terraform**
```bash
terraform init -var-file=envs/dev/dev.tfvars

2. Validate Configuration
terraform validate

3. Plan Deployment
terraform plan -var-file=envs/dev/dev.tfvars

4. Apply Deployment
terraform apply -var-file=envs/dev/dev.tfvars

5. Destroy Infrastructure
terraform destroy -var-file=envs/dev/dev.tfvars


Variables

Some key variables used in dev.tfvars:

project_name       = "project2-dev"
aws_region         = "us-east-1"
vpc_id             = "vpc-xxxxxxxxxxxx"
public_subnet_ids  = ["subnet-xxxxxx", "subnet-xxxxxx"]
private_subnet_ids = ["subnet-xxxxxx", "subnet-xxxxxx"]
db_instance_class  = "db.t3.micro"
db_engine          = "mysql"
db_secret_arn      = "arn:aws:secretsmanager:us-east-1:xxxx:secret:project2/db_password-xxxx"
alb_dns_name       = "<output-from-ALB-module>"
alb_zone_id        = "<output-from-ALB-module>"


Outputs

After applying, Terraform provides outputs such as:
EC2 public/private IPs
RDS endpoint
ALB DNS
S3 bucket name
CloudFront distribution URL

Conclusion
Project 2 demonstrates the implementation of a scalable, secure, and fully automated AWS infrastructure using Terraform. By following best practices for modularity, secrets management, and environment separation, this project ensures high availability, security, and maintainability for cloud-native applications.
