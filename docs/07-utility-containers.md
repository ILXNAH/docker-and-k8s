# 7. Working With 'Utility Containers' & Executing Commands In Containers
## 📁 Table of Contents
- [🧾 Module Intro](#-module-introduction)
- [❔ The Purpose of Utility Containers - Why Use Them](#-the-purpose-of-utility-containers---why-use-them)
- [🔧 Different Ways of Running Commands in Containers](#-different-ways-of-running-commands-in-containers)
- [🏗 Building a Utility Container](#-building-a-utility-container)
- [⚙️ Utilizing ENTRYPOINT](#-utilizing-entrypoint)
- [🐳 Using Docker Compose](#-using-docker-compose)
  - [🔒 Define Linux User & Permissions for Utility Container](#-define-linux-user--permissions-for-utility-container)
- [Module Summary & Resources](#module-summary--resources)

---

## 🧾 Module Introduction
Docker is mainly used for **Application Containers**:  
App + Environment  
→ `docker run myapp`  
→ Runs CMD and starts app.

**Utility Containers**, on the other hand:
- Only contain a certain environment, e.g., NodeJS or PHP.
- Do not start an application automatically.
- Example: `docker run mynpm init` executes the provided command.

## ❔ The Purpose of Utility Containers - Why Use Them?
To create a Node app, you need a `package.json` describing the app and dependencies:
- Run `npm init` in the project folder to create it.
- This requires NodeJS (or similar tools) installed **locally**, which is often undesirable.

> **Initial project creation requires language runtimes and development tools, which Utility Containers help avoid installing locally.**

## 🔧 Different Ways of Running Commands in Containers
```bash
docker run -it node
```
- Runs an interactive NodeJS container.

```bash
docker run -it -d node
```
- Detached mode (can reattach with `docker container attach <ID>`).

```bash
docker exec -it <ID> npm init
```
- Executes a command inside a running container.

```bash
docker run -it node npm init
```
- Runs the container and overrides the default command.

## 🏗 Building a Utility Container
Example `Dockerfile`:
```dockerfile
FROM node:14-alpine

WORKDIR /app
```

Build the image:
```bash
docker build -t node-util .
```

Run with bind mount:
```bash
docker run -it -v /root/docker-and-k8s/07-utility-containers:/app node-util npm init
```

> **Note:**  
If you define `CMD` in the `Dockerfile`, commands passed to `docker run` will overwrite it.  
To allow appending commands, use `ENTRYPOINT` instead.

## ⚙ Utilizing ENTRYPOINT
Restricts container usage (e.g., npm-only):
```dockerfile
FROM node:14-alpine

WORKDIR /app

ENTRYPOINT [ "npm" ]
```

Build:
```bash
docker build -t mynpm .
```

Run:
```bash
docker run -it -v /root/docker-and-k8s/07-utility-containers:/app mynpm init
```

Install dependencies:
```bash
docker run -it -v /root/docker-and-k8s/07-utility-containers:/app mynpm install express --save
```
> In **npm v5+**, `--save` is the default.

## 🐳 Using Docker Compose
Example `docker-compose.yml`:
```yaml
version: "3.8"
services:
  npm:
    build: ./
    stdin_open: true
    tty: true
    volumes:
      - ./:/app
```
Run commands:
```bash
docker-compose exec npm <command>
docker-compose run --rm npm init
```
> By default, containers stop after the command finishes but are not automatically removed (unless using `--rm`).

### 🔒 Define Linux User & Permissions for Utility Container
- A simple method is included as comments in the [provided Dockerfile](/07-utility-containers/Dockerfile).
- More advanced approach: [vsupalov.com/docker-shared-permissions](https://vsupalov.com/docker-shared-permissions/).

## Module Summary & Resources
- Laravel PHP environment setup can be challenging.
- Next section will focus on creating a dummy Laravel application.

### 📚 Module Resources
- [Slides - Utility Containers](https://ilxnah.github.io/docker-and-k8s/resources/slides-utility-containers.pdf)
- ![Utility Containers Summary](/resources/images/20250501171701.png)