#!/bin/bash

# Docker build script for CloudOps Dashboard
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🐳 Building CloudOps Dashboard Docker Images${NC}"

# Configuration
REGISTRY=${DOCKER_REGISTRY:-"localhost:5000"}
VERSION=${VERSION:-"latest"}
FRONTEND_IMAGE="${REGISTRY}/cloudops-frontend:${VERSION}"
BACKEND_IMAGE="${REGISTRY}/cloudops-backend:${VERSION}"

# Build frontend
echo -e "${YELLOW}📦 Building frontend image...${NC}"
docker build -t $FRONTEND_IMAGE ./apps/frontend
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Frontend image built successfully${NC}"
else
    echo -e "${RED}❌ Frontend build failed${NC}"
    exit 1
fi

# Build backend
echo -e "${YELLOW}📦 Building backend image...${NC}"
docker build -t $BACKEND_IMAGE ./apps/backend
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Backend image built successfully${NC}"
else
    echo -e "${RED}❌ Backend build failed${NC}"
    exit 1
fi

# Show built images
echo -e "${GREEN}📋 Built images:${NC}"
docker images | grep cloudops

# Optional: Push to registry
if [ "$PUSH_IMAGES" = "true" ]; then
    echo -e "${YELLOW}🚀 Pushing images to registry...${NC}"
    docker push $FRONTEND_IMAGE
    docker push $BACKEND_IMAGE
    echo -e "${GREEN}✅ Images pushed successfully${NC}"
fi

echo -e "${GREEN}🎉 Docker build completed successfully!${NC}" 