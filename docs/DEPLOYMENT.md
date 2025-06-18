# CloudOps Dashboard - Deployment Guide

## 🏗️ Architecture Overview

The CloudOps Dashboard is a production-ready, enterprise-grade DevOps platform built with modern cloud-native technologies.

### System Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           CLOUDOPS DASHBOARD ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐             │
│  │   FRONTEND      │    │   BACKEND API   │    │   DATABASE      │             │
│  │   (Next.js 14)  │───▶│   (Express.js)  │───▶│   (PostgreSQL)  │             │
│  │   Port: 3000    │    │   Port: 8080    │    │   Port: 5432    │             │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘             │
│           │                       │                       │                     │
│           └───────────────────────┼───────────────────────┘                     │
│                                   │                                             │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│                                   │                                             │
│                        DOCKER CONTAINERS                                        │
│                                   │                                             │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│                                   │                                             │
│                    KUBERNETES ORCHESTRATION                                     │
│                                   │                                             │
│  ┌─────────────────────────────────┼─────────────────────────────────────────┐ │
│  │               MINIKUBE (Local) / EKS (Cloud)               │               │ │
│  │                                                           │               │ │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────┐             │               │ │
│  │  │   Pod 1   │  │   Pod 2   │  │   Pod 3   │             │               │ │
│  │  └───────────┘  └───────────┘  └───────────┘             │               │ │
│  │                                                           │               │ │
│  │  ┌─────────────────────────────────────────────────────┐ │               │ │
│  │  │              INGRESS / LOAD BALANCER                │ │               │ │
│  │  └─────────────────────────────────────────────────────┘ │               │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                   │                                             │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│                                   │                                             │
│                    INFRASTRUCTURE AS CODE                                       │
│                                   │                                             │
│  ┌─────────────────────────────────┼─────────────────────────────────────────┐ │
│  │                            TERRAFORM                                       │ │
│  │                                                                           │ │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │ │
│  │  │   VPC   │  │   EKS   │  │   RDS   │  │   ALB   │  │   ECR   │        │ │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘        │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                   │                                             │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│                                   │                                             │
│                          CI/CD PIPELINE                                        │
│                                   │                                             │
│  ┌─────────────────────────────────┼─────────────────────────────────────────┐ │
│  │                        GITHUB ACTIONS                                     │ │
│  │                                                                           │ │
│  │  Test → Security → Build → Deploy → Monitor                              │ │
│  │                                                                           │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start Guide

### Prerequisites

Before deploying the CloudOps Dashboard, ensure you have the following tools installed:

- **Node.js 18+** - JavaScript runtime
- **Docker** - Container platform
- **kubectl** - Kubernetes CLI
- **Minikube** - Local Kubernetes cluster
- **Terraform** - Infrastructure as Code tool
- **Git** - Version control

### 1. Local Development with Docker Compose

The fastest way to get started:

```bash
# Clone the repository
git clone https://github.com/noahwilliamshaffer/InfrustructureAsCode.git
cd InfrustructureAsCode

# Install dependencies
npm install

# Start the development environment
npm run docker:up

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8080
# Database: localhost:5432
```

### 2. Local Kubernetes Deployment with Minikube

For a production-like environment:

```bash
# Make the script executable (Linux/Mac)
chmod +x scripts/deploy-local.sh

# Run the deployment script
./scripts/deploy-local.sh

# Or manually on Windows:
bash scripts/deploy-local.sh
```

This script will:
- ✅ Check all prerequisites
- 🎯 Start Minikube cluster
- 🐳 Build Docker images
- 🔐 Create Kubernetes secrets
- 💾 Set up persistent storage
- 🚀 Deploy all applications
- 🌐 Configure ingress routing

### 3. Cloud Deployment with Terraform

For production deployment on AWS:

```bash
# Configure AWS credentials
aws configure

# Initialize Terraform
cd infrastructure/terraform
terraform init

# Plan the deployment
terraform plan

# Apply the infrastructure
terraform apply

# Configure kubectl
aws eks --region us-west-2 update-kubeconfig --name cloudops-dashboard-production-eks
```

## 📊 Monitoring & Health Checks

### Health Check Endpoints

- **Frontend Health**: `http://localhost:3000/`
- **Backend Health**: `http://localhost:8080/api/health`
- **Detailed Health**: `http://localhost:8080/api/health/detailed`
- **Liveness Probe**: `http://localhost:8080/api/health/live`
- **Readiness Probe**: `http://localhost:8080/api/health/ready`

### System Status API

```bash
# Get system status
curl http://localhost:8080/api/system/status

# Get deployment info
curl http://localhost:8080/api/system/deployment

# Get metrics
curl http://localhost:8080/api/system/metrics

# Get CI/CD pipeline status
curl http://localhost:8080/api/system/pipeline
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `NODE_ENV` | Environment (development/production) | `production` |
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://...` |
| `FRONTEND_URL` | Frontend application URL | `http://localhost:3000` |
| `PORT` | Backend server port | `8080` |

### Kubernetes Configuration

The application uses several Kubernetes resources:

- **Namespaces**: `cloudops`, `cloudops-staging`
- **Deployments**: Frontend (3 replicas), Backend (2 replicas), Database (1 replica)
- **Services**: ClusterIP and LoadBalancer services
- **Secrets**: Database credentials and connection strings
- **PersistentVolumes**: Database storage

## 🛠️ Troubleshooting

### Common Issues

1. **Minikube won't start**
   ```bash
   minikube delete
   minikube start --driver=docker
   ```

2. **Images not found**
   ```bash
   eval $(minikube docker-env)
   ./scripts/docker-build.sh
   ```

3. **Pods stuck in Pending**
   ```bash
   kubectl describe pods -n cloudops
   kubectl get events -n cloudops
   ```

4. **Database connection issues**
   ```bash
   kubectl logs deployment/cloudops-postgres -n cloudops
   kubectl exec -it deployment/cloudops-postgres -n cloudops -- psql -U postgres
   ```

### Useful Commands

```bash
# View all resources
kubectl get all -n cloudops

# Check pod logs
kubectl logs -f deployment/cloudops-frontend -n cloudops

# Port forward services
kubectl port-forward svc/cloudops-frontend 3000:3000 -n cloudops
kubectl port-forward svc/cloudops-backend 8080:8080 -n cloudops

# Scale deployments
kubectl scale deployment cloudops-frontend --replicas=5 -n cloudops

# Update deployment
kubectl set image deployment/cloudops-frontend frontend=cloudops-frontend:v2 -n cloudops
```

## 🔒 Security Features

- **Non-root containers** - All containers run as non-root users
- **Security contexts** - Restricted security policies
- **Network policies** - Controlled network access
- **Secrets management** - Kubernetes secrets for sensitive data
- **Image scanning** - Trivy security scanning in CI/CD
- **HTTPS/TLS** - SSL termination at load balancer
- **Security headers** - Helmet.js security middleware

## 📈 Performance & Scaling

- **Horizontal Pod Autoscaling** - Automatic scaling based on CPU/memory
- **Rolling deployments** - Zero-downtime deployments
- **Health checks** - Liveness and readiness probes
- **Resource limits** - CPU and memory constraints
- **Load balancing** - Traffic distribution across pods

## 🎯 Production Checklist

- [ ] DNS configuration
- [ ] SSL certificates
- [ ] Monitoring setup (Prometheus/Grafana)
- [ ] Logging aggregation (ELK/Fluentd)
- [ ] Backup strategy
- [ ] Disaster recovery plan
- [ ] Security scanning
- [ ] Performance testing
- [ ] Documentation
- [ ] Team training

## 📚 Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Next.js Documentation](https://nextjs.org/docs)
- [Express.js Guide](https://expressjs.com/en/guide/routing.html)

---

🚀 **Happy Deploying!** The CloudOps Dashboard is ready for enterprise-scale deployments. 