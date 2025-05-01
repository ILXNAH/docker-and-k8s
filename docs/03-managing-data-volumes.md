# 3. Managing Data & Working With Volumes

## 📁 Table of Contents

- [Writing, Reading & Persisting Data](#writing-reading--persisting-data)
- [1. Understanding Different Kinds of Data](#1-understanding-different-kinds-of-data)
   - [Three Data Categories](#three-data-categories)
     - [1.1 Application (Code + Environment)](#11-application-code--environment)
     - [1.2 Temp App Data (e.g. entered user input)](#12-temp-app-data-eg-entered-user-input)
     - [1.3 Permanent App Data (e.g. user accounts)](#13-permanent-app-data-eg-user-accounts)
   - [Analyzing a real app; building & understanding the demo](#analyzing-a-real-app-building--understanding-the-demo)
- [2. Understanding Volumes](#2-understanding-volumes)
   - [Two Types of External Data Storages](#two-types-of-external-data-storages)
     - [2.1. Volumes (Managed by Docker)](#1-volumes-managed-by-docker)
       - [Two Types of Volumes:](#two-types-of-volumes)
         - [2.1.1. Anonymous Volumes](#1-anonymous-volumes)
         - [2.1.2. Named Volumes](#2-named-volumes)
     - [2.2. Bind Mounts (managed by you)](#2-bind-mounts-managed-by-you)
   - [Understanding Container / Volume Interaction](#understanding-container--volume-interaction)
     - [WSL & Bind Mounts](#wsl--bind-mounts)
   - [Overview: Volumes & Mounts](#overview-volumes--mounts)
   - [Read-only Volumes](#read-only-volumes)
   - [Managing Docker Volumes](#managing-docker-volumes)
   - [dockerignore](#dockerignore)
- [Arguments & Environment Variables](#arguments--environment-variables)
   - [ARG](#arg)
   - [ENV](#env)
     - [Set ENV in Dockerfile](#set-env-in-dockerfile)
     - [Set ENV in Docker CLI](#set-env-in-docker-cli)
     - [Security note to storing ENVs](#security-note-to-storing-envs)
- [Module Summary](#module-summary)

---

## Writing, Reading & Persisting Data

1. Understanding Different Kinds of Data
2. Images, Containers & Volumes
3. Using Arguments & Environment Variables

# 1. Understanding Different Kinds of Data

### Three Data Categories

#### 1.1 Application (Code + Environment)
- Written & provided by the developer.
- Added to image and container in build phase.
- "Fixed": Cannot be changed once image is built (image is read-only).
- **Stored in images as read-only data.**

#### 1.2 Temp App Data (e.g. entered user input)
- Fetched/produced in running container.
- Stored in memory or temporary files.
- Dynamic, changing, cleared regularly.
- **Stored in the container's read-write layer.**

#### 1.3 Permanent App Data (e.g. user accounts)
- Produced inside container.
- Stored in files or databases.
- Must persist even if the container stops/restarts.
- **Stored with containers & volumes.**

### Analyzing a real app; building & understanding the demo

- Data persists after container stop/start unless `--rm` flag is used.
- Images have read-only layers, containers have writable layers.
- Multiple containers based on the same image are isolated.

## 2. Understanding Volumes

- Volumes = folders on your host hard drive mounted into containers.
- Volumes persist container shutdowns.
- Containers can read/write to volumes.

### Two Types of External Data Storages

#### 2.1. Volumes (Managed by Docker)

##### Two Types of Volumes:

###### 2.1.1. Anonymous Volumes
- Auto-generated name.
- Deleted with `--rm`, or kept manually.
- Cannot be reused by new containers.
- Managed via `docker volume` commands:
  - `docker volume ls`
  - `docker volume rm <NAME>`
  - `docker volume prune`

###### 2.1.2. Named Volumes
- You define their name.
- Persist even after container shutdown.
- Great for persistent app data.
- Run example: `-v feedback:/app/feedback`

#### 2.2. Bind Mounts (managed by you)

- You define the host path.
- Great for editable persistent data (e.g. source code).
- Examples:
  - Windows: `-v "%cd%":/app`
  - macOS/Linux: `-v $(pwd):/app`

### Understanding Container / Volume Interaction

- You can combine volume types.
- Specific/longer path mounts are preferred.
- Use `VOLUME` in `Dockerfile` for container-specific paths.

### WSL & Bind Mounts

- Special consideration needed for file events in WSL.

### Overview: Volumes & Mounts

- Anonymous Volume: `docker run -v /app/data`
- Named Volume: `docker run -v data:/app/data`
- Bind Mount: `docker run -v /path/to/code:/app/code`

### Read-only Volumes

- Add `:ro` flag to make volume read-only.
- e.g. `-v /some/path:/container/path:ro`

### Managing Docker Volumes

- `docker volume --help`
- `docker volume ls`
- `docker volume create`
- `docker volume inspect <NAME>`
- `docker volume prune`

### dockerignore

Example `.dockerignore` file:

```plaintext
.git
Dockerfile
node_modules
```

## Arguments & Environment Variables

### ARG

- Build-time variable (available only inside `Dockerfile`).
- Set during `docker build` with `--build-arg`.

### ENV

- Runtime and build-time variable.
- Can be set:
  - In Dockerfile: `ENV PORT 80`
  - In CLI: `docker run --env PORT=8000`

#### Set ENV in Dockerfile

```dockerfile
ENV PORT 80
EXPOSE $PORT
```

#### Set ENV in Docker CLI

```bash
docker run -d --rm -p 3000:8000 --env PORT=8000 --name feedback-app -v feedback:/app/feedback feedback-node:env
```

Or with `.env` file:

```plaintext
PORT=8000
```

Then use:

```bash
docker run --env-file ./.env ...
```

#### Security note to storing ENVs

- Never include sensitive ENV vars in `Dockerfile`.
- Use external `.env` files or CLI `--env` for secrets.

## Module Summary

![Module Summary](resources/images/20250428085444.png)