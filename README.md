# AWS Terraform Architecture

This project provisions a simple AWS networking environment using Terraform. It creates a VPC with both public and private subnets, routes internet traffic through an internet gateway, and provides outbound connectivity for private resources through a NAT gateway.

## Architecture overview

```text
                         Internet
                             │
                             ▼
                  +----------------------+
                  |     Internet         |
                  |      Gateway         |
                  +----------+-----------+
                             │
                             ▼
                  +----------------------+
                  |   Public Subnet A    |
                  |   10.0.1.0/24        |
                  |  NAT Gateway + IGW   |
                  +----------+-----------+
                             │
                  +----------+-----------+
                  |   Public Subnet B    |
                  |   10.0.2.0/24        |
                  +----------------------+
                             │
                             ▼
                  +----------------------+
                  |     VPC 10.0.0.0/16  |
                  |                      |
                  |  Private Subnet      |
                  |  10.0.11.0/24        |
                  |  (private resources) |
                  +----------------------+
```

## Components

### VPC

- A single VPC is created using the CIDR `10.0.0.0/16`.
- This acts as the isolated network boundary for the environment.

### Public subnets

- Two public subnets are configured in different availability zones:
  - `10.0.1.0/24` in `us-east-1a`
  - `10.0.2.0/24` in `us-east-1b`
- These subnets allow resources to communicate directly with the internet.

### Internet gateway

- An internet gateway is attached to the VPC.
- It enables public traffic to flow between the VPC and the public internet.

### Route tables

- The public route table sends all internet-bound traffic (`0.0.0.0/0`) to the internet gateway.
- The private route table sends all non-local traffic to the NAT gateway instead of directly to the internet.

### NAT gateway

- A NAT gateway is created in a public subnet and uses an Elastic IP.
- It allows instances in the private subnet to initiate outbound internet connections while remaining private.
- This is useful for workloads that need outbound access without exposing inbound internet ports.

### Private subnet

- One private subnet is defined:
  - `10.0.11.0/24` in `us-east-1a`
- This subnet is intended for internal resources that should not be directly accessible from the internet.

### S3 bucket

- The project also provisions an S3 bucket for learning/demo use.
- The bucket name is derived from the configured `bucket_prefix`, project name, and environment.

## Traffic flow

- Public resources can access the internet through the internet gateway.
- Private resources send outbound traffic through the NAT gateway.
- Inbound internet traffic is not directly exposed to the private subnet.

## Why this pattern is useful

This architecture follows a common AWS best practice:

- public subnets host internet-facing resources
- private subnets host internal-only resources
- NAT allows outbound internet access without exposing private instances publicly

## Terraform files

The configuration is split by concern:

- `vpc.tf` — VPC
- `subnet.tf` — public and private subnets
- `internet-gateway.tf` — internet gateway
- `route-table.tf` — route tables and associations
- `nat.tf` — NAT gateway and private routing
- `main.tf` — core S3 bucket configuration
- `provider.tf` — AWS provider settings
- `variables.tf` — reusable variables
- `outputs.tf` — outputs for resource metadata

## Notes

This environment is a basic reference architecture for learning Terraform and AWS networking. It can be expanded to include EC2 instances, security groups, ALBs, and additional private subnets as needed.
