# Section 1: Getting Started

## 📑 Table of Contents

- [What is Docker?](#-what-is-docker)
- [What is a Container?](#-what-is-a-container)
- [Virtual Machines vs Containers](#-virtual-machines-vs-containers)
- [Docker Containers](#-docker-containers)
- [Docker Setup](#️️️️️️⚙️-docker-setup)
- [Docker Tools & Building Blocks](#-docker-tools--building-blocks)
- [IDE Setup](#-ide-setup)
- [Create and Run a Container](#-create-and-run-a-container)
- [Course Outline](#-course-outline)
- [Resources for Section 1](#-resources-for-section-1)

---

[🔗 Udemy Course Link](https://www.udemy.com/course/docker-kubernetes-the-practical-guide/learn/lecture/22166652#overview)  
[🔗 Discord Community](https://academind.com/community/)

---

## 🐳 What is Docker?

Docker helps build and manage containers.

---

## 📦 What is a Container?

A container is a **standardized unit**:
- Independent from other containers
- Self-contained
- Easily movable

### Why use containers?
- Create **independent, standardized environments** for all phases of the SDLC
- Improve **reproducibility**
- Avoid **version conflicts** between tools, libraries, and applications

---

## 💻 Virtual Machines vs Containers

| Virtual Machines | Containers |
|:---|:---|
| Install full OS + apps + tools + libs | Only apps/tools with minimal OS footprint |
| Heavyweight (long boot times, large disk usage) | Lightweight, minimal overhead |
| Good separation | Excellent separation with better performance |
| Resource duplication possible | Resource-efficient |

---

## 🐳 Docker Containers

- Defined via **configuration files** (Dockerfiles) or **images**
- **Low OS impact**, **fast startup**, **small disk usage**
- **Easy to share**, rebuild, and distribute
- Encapsulate only what is needed (apps, tools, dependencies)

---

## ⚙️ Docker Setup

- [Install Docker Engine](https://docs.docker.com/engine/install/)
- [Install Docker Desktop (for Windows + WSL2)](https://docs.docker.com/desktop/setup/install/windows-install/)
- [📄 Installing Docker on Windows (PDF)](../resources/Installing%2BDocker%2Bon%2BWindows.pdf)

---

## 🛠 Docker Tools & Building Blocks

- **Docker Engine / Docker Desktop**: daemon and CLI
- **Docker Hub**: host and share images  
  [My Docker Hub repository](https://hub.docker.com/repositories/ilouckov)
- **Docker Compose**: multi-container orchestration (introduced in Section 6)
- **Kubernetes** (later in course)

---

## 🧰 IDE Setup

- Visual Studio Code
- Extensions:
  - Docker Extension
  - Prettier Extension

---

## 🐳 Create and Run a Container

### Create Dockerfile with configuration
```bash
docker build .
``` 

### View built images
```bash
docker images
``` 

### Run container with port mapping (example: map port 3000)
```bash
docker run -p 3000:3000 <IMAGE_ID>
``` 

### View running containers
```bash
docker ps
``` 

### Stop running container
```bash
docker stop <CONTAINER_ID>
``` 

## 🗺 Course Outline

- **Getting Started & Overview**
- **Foundation**
  - Images & Containers
  - Data & Volumes (in Containers)
  - Containers & Networking
- **Real Life/Advanced Concepts**
  - Multi-container Project
  - Docker Compose
  - Utility Containers
  - Deploying Docker Containers (with AWS)
- **Kubernetes**
  - Introduction & Basics
  - Data & Volumes in Kubernetes
  - Deploy Kubernetes Cluster / Deploy Containers with Kubernetes

---

## 📚 Resources for Section 1

- [📄 Slides: Getting Started](../resources/slides-getting-started.pdf)
- [📦 Demo Code: First Dockerized App](../resources/first-demo-dockerized.zip)
