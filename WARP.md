# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Architecture Overview

This repository demonstrates a complete CI/CD pipeline for deploying a Node.js web application to Google Kubernetes Engine (GKE). The architecture consists of:

- **Node.js Application**: Simple Express server (`src/app/`) serving a basic web application
- **Containerization**: Docker-based containerization with multi-stage optimization 
- **Kubernetes Orchestration**: Helm charts for Kubernetes deployment with configurable values
- **CI/CD Pipeline**: GitHub Actions workflows for automated testing and deployment
- **Cloud Infrastructure**: Google Cloud Platform with GKE, Artifact Registry, and Workload Identity

The deployment flow: Code changes → CI testing → Docker image build → GCP Artifact Registry → GKE deployment via Helm.

## Common Development Commands

### Local Development
```bash
# Install dependencies
cd src/app && npm install

# Run the application locally
cd src/app && npm start

# Run tests
cd src/app && npm test
```

### Docker Operations
```bash
# Build Docker image locally
docker build -t sample-web-app .

# Run containerized application
docker run -p 3000:3000 sample-web-app

# Build with specific tag for GCP
docker build -t "us-docker.pkg.dev/PROJECT_ID/sample-workflows/sample-web-app:TAG" .
```

### Helm Operations
```bash
# Install Helm chart locally (requires kubectl context)
helm install sample-web-app charts/sample-web-app

# Upgrade deployment with new image
helm upgrade sample-web-app charts/sample-web-app \
  --set image.repository="us-docker.pkg.dev/PROJECT_ID/sample-workflows/sample-web-app" \
  --set image.tag="NEW_TAG"

# Validate Helm templates
helm template sample-web-app charts/sample-web-app

# Uninstall release
helm uninstall sample-web-app
```

### GCP and Kubernetes
```bash
# Get GKE credentials
gcloud container clusters get-credentials CLUSTER_NAME --region REGION

# Configure Docker for Artifact Registry
gcloud auth configure-docker us-docker.pkg.dev

# Check deployment status
kubectl get deployments
kubectl get pods
kubectl get services

# View application logs
kubectl logs -l app=sample-web-app
```

## Key Configuration Files

### Helm Chart Configuration
- `charts/sample-web-app/values.yaml`: Default values for Kubernetes deployment
  - Image repository and tag configuration
  - Service type and port settings
  - Environment variables (NODE_ENV, PORT)
  - Resource limits and node selection

### GitHub Actions Secrets Required
The CI/CD pipeline requires these repository secrets:
- `WIF_PROVIDER`: Workload Identity Federation provider
- `WIF_SERVICE_ACCOUNT`: Service account for authentication
- `GKE_CLUSTER`: Target GKE cluster name
- `GKE_REGION`: GKE cluster region
- `GCP_PROJECT_ID`: Google Cloud project ID

### Docker Build Context
The Dockerfile expects the Node.js application to be in `src/app/` with `package.json` and source files. Build context is the repository root.

## Development Workflow

1. **Local Changes**: Make code changes in `src/app/`
2. **Testing**: Run `npm test` in the app directory 
3. **Containerization**: Test with `docker build` and `docker run`
4. **Helm Validation**: Use `helm template` to validate Kubernetes manifests
5. **CI/CD**: Push to main branch triggers automated build and deployment

## Project Structure Notes

- **Two-tier CI/CD**: Separate workflows for CI (`ci.yml`) and deployment (`deploy.yml`)
- **Helm Chart Organization**: Standard Helm structure with templates, values, and Chart.yaml
- **GCP Integration**: Uses Workload Identity Federation for secure authentication
- **NGINX Ingress**: Automatically installs NGINX ingress controller during deployment
- **Image Versioning**: Uses git commit SHA for image tagging to ensure traceability