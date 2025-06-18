# CloudOps Dashboard

🚀 **Enterprise-Grade DevOps Platform** - A production-ready Next.js full-stack application demonstrating modern Infrastructure-as-Code (IaC), containerization, and CI/CD workflows.

## 🎯 Project Goals

- **Reliability**: Zero-downtime deployments with health checks and rollback capabilities
- **Portability**: Containerized architecture running consistently across environments
- **Maintainability**: Clean code, comprehensive testing, and GitOps principles
- **Scalability**: Kubernetes-native with horizontal pod autoscaling

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend API   │    │   Database      │
│   (Next.js)     │───▶│   (Node.js)     │───▶│   (PostgreSQL)  │
│   Port: 3000    │    │   Port: 8080    │    │   Port: 5432    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🛠️ Technology Stack

### Frontend
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type-safe development
- **Tailwind CSS** - Utility-first styling
- **Shadcn/UI** - Modern component library

### Backend
- **Node.js/Express** - RESTful API server
- **PostgreSQL** - Primary database
- **Prisma** - Database ORM

### DevOps & Infrastructure
- **Docker** - Containerization
- **Kubernetes/Minikube** - Container orchestration
- **Terraform** - Infrastructure as Code
- **GitHub Actions** - CI/CD automation
- **Helm** - Kubernetes package management

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Docker & Docker Compose
- Minikube
- Terraform
- kubectl
- Helm

### Local Development
```bash
# Clone the repository
git clone https://github.com/noahwilliamshaffer/InfrustructureAsCode.git
cd InfrustructureAsCode

# Install dependencies
npm install

# Start development environment
docker-compose up -d

# Run the application
npm run dev
```

### Production Deployment
```bash
# Deploy to Minikube
./scripts/deploy-local.sh

# Deploy to cloud (AWS/GCP/Azure)
./scripts/deploy-cloud.sh
```

## 📁 Project Structure

```
├── apps/
│   ├── frontend/           # Next.js application
│   └── backend/            # Express API server
├── infrastructure/
│   ├── terraform/          # Terraform configurations
│   ├── kubernetes/         # K8s manifests
│   └── helm/              # Helm charts
├── .github/
│   └── workflows/         # GitHub Actions CI/CD
├── docker/                # Docker configurations
├── scripts/               # Automation scripts
└── docs/                  # Documentation
```

## 🔄 CI/CD Workflow

1. **Code Push** → Triggers GitHub Actions
2. **Quality Gates** → Linting, testing, security scanning
3. **Build & Package** → Docker images pushed to registry
4. **Infrastructure** → Terraform provisions/updates resources
5. **Deploy** → Kubernetes rolling deployment
6. **Verify** → Integration tests and health checks

## 📊 Monitoring & Observability

- **Health Checks**: Kubernetes liveness/readiness probes
- **Metrics**: Prometheus & Grafana dashboards
- **Logging**: Centralized logging with ELK stack
- **Alerting**: Slack/email notifications for incidents

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details. 