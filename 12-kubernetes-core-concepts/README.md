
# Kubernetes Core Concepts (Section 12)

Hands-on labs and examples for mastering core Kubernetes concepts.  
This project is part of the Docker & Kubernetes course (Section 12).

## Table of Contents
1. [Docker Hub Image](#-docker-hub-image)
2. [Repository](#-repository)
3. [Commands Used for Hands-on Kubernetes Labs](#-commands-used-for-hands-on-kubernetes-labs)
    - [Build and prepare the Docker image](#-build-and-prepare-the-docker-image)
    - [Minikube setup](#-minikube-setup)
    - [Kubernetes basics](#-kubernetes-basics)
    - [Prepare and push image to Docker Hub](#-prepare-and-push-image-to-docker-hub)
    - [Deploy using the pushed Docker Hub image](#-deploy-using-the-pushed-docker-hub-image)

## 🐳 Docker Hub Image

You can pull the app image used in this section from Docker Hub:

👉 [ilouckov/k8s-first-app](https://hub.docker.com/r/ilouckov/k8s-first-app)

```bash
docker pull ilouckov/k8s-first-app
```

## 📁 Repository

All manifests and source code:  
[github.com/ILXNAH/docker-and-k8s/tree/main/12-kubernetes-core-concepts](https://github.com/ILXNAH/docker-and-k8s/tree/main/12-kubernetes-core-concepts)

## 🛠 Commands Used for Hands-on Kubernetes Labs

### 🔹 Build and prepare the Docker image

```bash
# Build the Docker image from the Dockerfile in the current directory
docker build -t k8s-first-app .
```

### 🔹 Minikube setup

```bash
# Check Minikube status
minikube status

# Start Minikube with the Docker driver (if not set by default)
minikube start --driver=docker

# (Optional) Set Docker as the default driver for future Minikube clusters
minikube config set driver docker

# Delete existing Minikube cluster (needed when changing drivers or config)
minikube delete

# Start a fresh Minikube cluster
minikube start

# View current Minikube configuration
minikube config view
```

### 🔹 Kubernetes basics

```bash
# Show help for kubectl commands
kubectl help

# Create a deployment using a locally built image (for testing)
kubectl create deployment k8s-first-app --image=k8s-first-app
# ❗ This command will fail because the Kubernetes nodes (Minikube) cannot access local Docker images directly.
# You would need to either:
# - Load the image into Minikube: minikube image load k8s-first-app
# - Or push the image to a registry like Docker Hub (which we do below).

# Check deployments and pods status
kubectl get deployments
kubectl get pods

# Delete the deployment
kubectl delete deployment k8s-first-app
```

### 🔹 Prepare and push image to Docker Hub

```bash
# Tag the local image for Docker Hub
docker image tag k8s-first-app ilouckov/k8s-first-app

# Push the image to Docker Hub
docker push ilouckov/k8s-first-app
```

### 🔹 Deploy using the pushed Docker Hub image

```bash
# Create a deployment using the Docker Hub image
kubectl create deployment k8s-first-app --image=ilouckov/k8s-first-app
```
