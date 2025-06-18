#!/bin/bash

# CloudOps Dashboard Local Deployment Script for Minikube
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 CloudOps Dashboard - Local Deployment to Minikube${NC}"

# Configuration
NAMESPACE="cloudops"
ENVIRONMENT="local"

# Check prerequisites
check_prerequisites() {
    echo -e "${YELLOW}📋 Checking prerequisites...${NC}"
    
    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        echo -e "${RED}❌ Docker is not running. Please start Docker first.${NC}"
        exit 1
    fi
    
    # Check if Minikube is installed
    if ! command -v minikube &> /dev/null; then
        echo -e "${RED}❌ Minikube is not installed. Please install Minikube first.${NC}"
        exit 1
    fi
    
    # Check if kubectl is installed
    if ! command -v kubectl &> /dev/null; then
        echo -e "${RED}❌ kubectl is not installed. Please install kubectl first.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ All prerequisites met${NC}"
}

# Start Minikube if not running
start_minikube() {
    echo -e "${YELLOW}🎯 Starting Minikube...${NC}"
    
    if minikube status | grep -q "Running"; then
        echo -e "${GREEN}✅ Minikube is already running${NC}"
    else
        minikube start --driver=docker --memory=8192 --cpus=4
        echo -e "${GREEN}✅ Minikube started successfully${NC}"
    fi
    
    # Enable necessary addons
    minikube addons enable ingress
    minikube addons enable dashboard
    minikube addons enable metrics-server
    
    # Configure Docker environment
    eval $(minikube docker-env)
}

# Build Docker images
build_images() {
    echo -e "${YELLOW}🐳 Building Docker images...${NC}"
    
    # Build frontend image
    echo -e "${BLUE}Building frontend image...${NC}"
    docker build -t cloudops-frontend:local ./apps/frontend
    
    # Build backend image
    echo -e "${BLUE}Building backend image...${NC}"
    docker build -t cloudops-backend:local ./apps/backend
    
    echo -e "${GREEN}✅ Docker images built successfully${NC}"
}

# Create Kubernetes secrets
create_secrets() {
    echo -e "${YELLOW}🔐 Creating Kubernetes secrets...${NC}"
    
    # Create namespace if it doesn't exist
    kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
    
    # Create database secret
    kubectl create secret generic cloudops-secrets \
        --namespace=$NAMESPACE \
        --from-literal=postgres-user=postgres \
        --from-literal=postgres-password=postgres123 \
        --from-literal=database-url="postgresql://postgres:postgres123@cloudops-postgres:5432/cloudops_db" \
        --dry-run=client -o yaml | kubectl apply -f -
    
    echo -e "${GREEN}✅ Secrets created successfully${NC}"
}

# Create service accounts
create_service_accounts() {
    echo -e "${YELLOW}👤 Creating service accounts...${NC}"
    
    # Create service accounts
    kubectl create serviceaccount cloudops-frontend --namespace=$NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
    kubectl create serviceaccount cloudops-backend --namespace=$NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
    kubectl create serviceaccount cloudops-postgres --namespace=$NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
    
    echo -e "${GREEN}✅ Service accounts created successfully${NC}"
}

# Create persistent volume for database
create_storage() {
    echo -e "${YELLOW}💾 Creating persistent storage...${NC}"
    
    cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-pv
  namespace: $NAMESPACE
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data/postgres
  storageClassName: standard
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
  namespace: $NAMESPACE
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
EOF
    
    echo -e "${GREEN}✅ Persistent storage created successfully${NC}"
}

# Deploy applications
deploy_applications() {
    echo -e "${YELLOW}🚀 Deploying applications...${NC}"
    
    # Set environment variables for deployment
    export ENVIRONMENT=$NAMESPACE
    export FRONTEND_IMAGE="cloudops-frontend:local"
    export BACKEND_IMAGE="cloudops-backend:local"
    
    # Apply Kubernetes manifests
    envsubst < infrastructure/kubernetes/namespace.yaml | kubectl apply -f -
    envsubst < infrastructure/kubernetes/deployment.yaml | kubectl apply -f -
    envsubst < infrastructure/kubernetes/service.yaml | kubectl apply -f -
    
    # Wait for deployments to be ready
    echo -e "${BLUE}Waiting for deployments to be ready...${NC}"
    kubectl rollout status deployment/cloudops-postgres -n $NAMESPACE --timeout=300s
    kubectl rollout status deployment/cloudops-backend -n $NAMESPACE --timeout=300s
    kubectl rollout status deployment/cloudops-frontend -n $NAMESPACE --timeout=300s
    
    echo -e "${GREEN}✅ Applications deployed successfully${NC}"
}

# Create ingress
create_ingress() {
    echo -e "${YELLOW}🌐 Creating ingress...${NC}"
    
    cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cloudops-ingress
  namespace: $NAMESPACE
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - host: cloudops.local
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: cloudops-backend
            port:
              number: 8080
      - path: /
        pathType: Prefix
        backend:
          service:
            name: cloudops-frontend
            port:
              number: 3000
EOF
    
    echo -e "${GREEN}✅ Ingress created successfully${NC}"
}

# Get access information
get_access_info() {
    echo -e "${YELLOW}📊 Getting access information...${NC}"
    
    # Get Minikube IP
    MINIKUBE_IP=$(minikube ip)
    
    # Get service URLs
    FRONTEND_URL="http://$MINIKUBE_IP:$(kubectl get svc cloudops-frontend-lb -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}')"
    BACKEND_URL="http://$MINIKUBE_IP:30080"
    
    echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
    echo -e "${BLUE}📋 Access Information:${NC}"
    echo -e "  Frontend: $FRONTEND_URL"
    echo -e "  Backend API: $BACKEND_URL"
    echo -e "  Health Check: $BACKEND_URL/api/health"
    echo -e "  Dashboard: minikube dashboard"
    echo ""
    echo -e "${YELLOW}📝 Useful Commands:${NC}"
    echo -e "  View pods: kubectl get pods -n $NAMESPACE"
    echo -e "  View services: kubectl get svc -n $NAMESPACE"
    echo -e "  View logs: kubectl logs -f deployment/cloudops-frontend -n $NAMESPACE"
    echo -e "  Port forward frontend: kubectl port-forward svc/cloudops-frontend 3000:3000 -n $NAMESPACE"
    echo -e "  Port forward backend: kubectl port-forward svc/cloudops-backend 8080:8080 -n $NAMESPACE"
}

# Main execution
main() {
    check_prerequisites
    start_minikube
    build_images
    create_secrets
    create_service_accounts
    create_storage
    deploy_applications
    create_ingress
    get_access_info
}

# Run main function
main "$@" 