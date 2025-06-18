# Outputs for CloudOps Dashboard Infrastructure

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

# EKS Outputs
output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster"
  value       = module.eks.cluster_iam_role_name
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  value       = module.eks.cluster_version
}

# Database Outputs
output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.db.db_instance_endpoint
  sensitive   = false
}

output "db_instance_name" {
  description = "RDS instance name"
  value       = module.db.db_instance_identifier
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = module.db.db_instance_port
}

output "db_subnet_group_id" {
  description = "RDS subnet group ID"
  value       = module.db.db_subnet_group_id
}

output "db_parameter_group_id" {
  description = "RDS parameter group ID"
  value       = module.db.db_parameter_group_id
}

# Load Balancer Outputs
output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = module.alb.lb_arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.lb_dns_name
}

output "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  value       = module.alb.lb_zone_id
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = module.alb.target_group_arns
}

# Container Registry Outputs
output "ecr_repository_url_frontend" {
  description = "URL of the frontend ECR repository"
  value       = aws_ecr_repository.frontend.repository_url
}

output "ecr_repository_url_backend" {
  description = "URL of the backend ECR repository"
  value       = aws_ecr_repository.backend.repository_url
}

# Security Group Outputs
output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = module.alb_security_group.security_group_id
}

output "database_security_group_id" {
  description = "Security group ID for the database"
  value       = module.database_security_group.security_group_id
}

# Certificate Outputs
output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.acm_certificate_arn
}

# kubectl Configuration
output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
}

# Application URLs
output "application_url" {
  description = "URL to access the application"
  value       = "https://${var.domain_name}"
}

output "api_url" {
  description = "URL to access the API"
  value       = "https://${var.domain_name}/api"
}

# Environment Information
output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
} 