# 5. Building Multi-Container Applications with Docker
## 📁 Table of Contents
- [🧾 Module content](#-module-content)
- [Demo project](#demo-project)
  - [Three building blocks](#three-building-blocks)
  - [Dockerization of all three project parts](#dockerization-of-all-three-project-parts)
    - [1️⃣ Database](#1️⃣-database)
    - [2️⃣ Backend](#2️⃣-backend)
    - [3️⃣ Frontend](#3️⃣-frontend)
  - [1. Dockerize database](#1-dockerize-database)
  - [2. Dockerize BE](#2-dockerize-be)
  - [3. Dockerize FE](#3-dockerize-fe)
  - [Putting all apps into the same network](#putting-all-apps-into-the-same-network)
  - [🚀 Optimize: Set up data persistence, access limitation, live source code updates etc.](#-optimize-set-up-data-persistence-access-limitation-live-source-code-updates-etc)
    - [Adding Data Persistence to MongoDB with Volumes](#adding-data-persistence-to-mongodb-with-volumes)
    - [Security, authentication, access limitation](#security-authentication-access-limitation)
      - [Standard MongoDB Connection String Format](#standard-mongodb-connection-string-format)
      - [Standalone Connection String to enforce access control](#standalone-connection-string-to-enforce-access-control)
      - [👉 Sidenote](#-sidenote)
    - [Volumes, Bind Mounts & Polishing for the NodeJS Container](#volumes-bind-mounts--polishing-for-the-nodejs-container)
    - [Optimization of Backend](#optimization-of-backend)
    - [Optimization of Frontend (React SPA Container)](#optimization-of-frontend-react-spa-container)
- [✅ Module Summary & Resources](#-module-summary--resources)

---

## 🧾 Module content
1. Combining multiple services to one app.
2. Working with multiple containers.

## Demo project
### Three building blocks
1. Mongo database.
2. BE = NodeJS REST API.
3. FE = React SPA (Single-Page Application).
    - Detached from the BE.
    - Started with a dev server that hosts the React SPA.

There are two separate web servers running in BE and in FE.

### Dockerization of all three project parts
#### 1️⃣ Database
- DB & BE already done in previous modules.
- Data in DB must persist.
- Access should be limited — [official mongo image](https://hub.docker.com/_/mongo/) provides user + password options.

#### 2️⃣ Backend
- Data persistence (logs).
- Live source code updates (needs a 3rd party package).

#### 3️⃣ Frontend
- Dockerizing React (challenging without a guide).
- Live source code updates.

### 1. Dockerize database
- There is no need to manually build the image since it is already available [here](https://hub.docker.com/_/mongo/).
- Run a container with: `docker run --name mongodb -d --rm -p 27017:27017 mongo`

### 2. Dockerize BE
- Create our own custom **[Dockerfile](/05-multi-container-apps/backend/Dockerfile)** for the BE app
- Edit BE mongodb address reference to `host.docker.internal`
- Rebuild the image
- Run with publishing the port exposed in the **Dockerfile** with: `docker run --name goals-backend --rm -d -p 80:80 goals-node`

### 3. Dockerize FE
- By default, the FE app exposes the port 3000.
- Build **[Dockerfile](/05-multi-container-apps/frontend/Dockerfile)** (with `FROM node:20` to ensure Node.js and dependency version compatibility).
- Afterwards, build the image from it with: `docker build -t goals-react .`
- From the image, run a container with: `docker run --name goals-frontend --rm -d -p 3000:3000 -it goals-react`
    - If the React app loses its input signal, it shuts down automatically.
- Open `http://localhost:3000/` to check that it's working.

### Putting all apps into the same network
```bash
docker network create goals-net
```
- Update app code to use container names.
- Rebuild and run containers with `--network goals-net`.

### 🚀 Optimize: Set up data persistence, access limitation, live source code updates etc.
#### Adding Data Persistence to MongoDB with Volumes
```bash
docker run --name mongodb -v data:/data/db --rm -d --network goals-net mongo
```

#### Security, authentication, access limitation
```bash
docker run --name mongodb -v data:/data/db --rm -d --network goals-net -e MONGO_INITDB_ROOT_USERNAME=ilona -e MONGO_INITDB_ROOT_PASSWORD=secret mongo
```

##### Standard MongoDB Connection String Format
```bash
mongodb://ilona:secret@mongodb:27017/course-goals
```

##### Standalone Connection String to enforce access control
```bash
mongodb://ilona:secret@mongodb:27017/course-goals?authSource=admin
```

##### 👉 Sidenote
If volume metadata exists, new users/credentials will not apply. To fix:
```bash
docker stop mongodb
docker volume rm data
```

#### Volumes, Bind Mounts & Polishing for the NodeJS Container
```bash
docker run --rm -d -p 80:80 --name goals-backend --network goals-net -v /root/docker-and-k8s/multi-container-apps/backend:/app -v logs:/app/logs -v /app/node_modules goals-node
```
- Use nodemon for live code updates.
- Add nodemon as a dev dependency.
- Update start script in `package.json`.
- Update Dockerfile to use npm start.

#### Optimization of Backend
- Set ENV variables in Dockerfile.
- Use `.dockerignore`.

#### Optimization of Frontend (React SPA Container)
```bash
docker run --name goals-frontend --rm -it -p 3000:3000 --network goals-net -v /root/docker-and-k8s/multi-container-apps/frontend/src:/app/src goals-react
```
- Live reload enabled.
- Optimize with `.dockerignore`.

## ✅ Module Summary & Resources
![Module Summary](/resources/images/20250430111319.png)

**Development Only environment setup:**  
Apps automatically reload on code changes (not recommended for production).

**Room for improvement:**  
- Long docker run commands.
- Development environment not optimized for production.

### 📚 Module Resources
- [Section 5 - Course Slides](https://ilxnah.github.io/docker-and-k8s/resources/slides-multi-container.pdf)