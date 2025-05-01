# 6. Docker Compose: Elegant Multi-Container Orchestration

## 📁 Table of Contents

- [🧾 Module Intro](#-module-intro)
- [💡 What is Docker Compose](#-what-is-docker-compose)
  - [❌ What it is NOT](#-what-it-is-not)
- [Creating a Compose File](#creating-a-compose-file)
- [⚙️ Compose File Config](#️-compose-file-config)
- [Docker Compose Up ⬆️ & Docker Compose Down ⬇️](#docker-compose-up-%EF%B8%8F--docker-compose-down-%EF%B8%8F)
- [🐳🐳🐳 Working with Multiple Containers - BE](#-working-with-multiple-containers---be)
- [Adding Another Container - FE](#adding-another-container---fe)
- [Building Images & Understanding Container Names](#building-images--understanding-container-names)
- [Module Summary & Resources](#module-summary--resources)

---

## 🧾 Module Intro

- List of commands summarized at the beginning of the video + in the repo/section folder as `docker-commands.txt`.
- docker-compose = multi-container setup automation.

## 💡 What is Docker Compose

- Tool allowing to replace `docker build` and `docker run` command(s) with **single config file + orchestration cmds** (build, start, stop).

### ❌ What it is NOT

- **Does not replace Dockerfiles** — it works together with them.
- **Does not replace images or containers** — it makes working with them easier.
- Not suited for managing multiple containers on different hosts / machines.

## Creating a Compose File

- Services (= Containers) and their config:
  - Published ports
  - Environment variables
  - Volumes
  - Networks
  - Anything else done via `docker run`

- 🔗 [Official documentation](https://docs.docker.com/reference/compose-file/) for Compose versions, config options etc.
- YAML is case-sensitive + correct indentation is essential.

## ⚙️ Compose File Config

- By default, docker-compose removes services when shut down (similar to using `--rm` in `docker run`).
- Key syntax:
  - Single value: starts with `-`.
  - Key-value pair: use `:`.

- Automatic network creation named `<project_name>_default`.
- Named volumes defined at top level (can be shared by multiple containers).
- Anonymous volumes and bind mounts don’t need separate definitions.

```yaml
volumes:
  data:
```

- Prefix for volume/container names: `<project_name>_volume_name`.

## Docker Compose Up ⬆️ & Docker Compose Down ⬇️

```bash
docker-compose up
docker-compose up -d
docker-compose down
docker-compose down -v   # remove volumes too
```

## 🐳🐳🐳 Working with Multiple Containers - BE

- Define BE app via `build` key:

```yaml
  build:
    context: ./backend
    dockerfile: Dockerfile-custom-name
    args:
      some-arg: 1
```

- Context must match the folder containing the Dockerfile.
- Bind-mount volumes use relative paths.
- Anonymous volume example:

```yaml
- /app/node_modules
```

- Container names can be long but the service name remains usable for code references.

## Adding Another Container - FE

Interactive mode (`-it`) in `docker run` corresponds to `stdin_open` + `tty`:

```yaml
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile
  ports:
    - '3000:3000'
  volumes:
    - ./frontend/src:/app/src
  stdin_open: true
  tty: true
  depends_on:
    - backend
```

## Building Images & Understanding Container Names

- `docker-compose up` rebuilds only if changes are detected.
- Force rebuild:

```bash
docker-compose up --build
```

- Build only:

```bash
docker-compose build
```

- Assign specific container names with `container_name` key.

## Module Summary & Resources

- Can be used for both multi-container and single-container projects.
- Simplistic bind-mount definitions.
- Only partially replaces `docker run` and `docker build`.
- Still part of the Docker ecosystem.

### 📚 Module Resources

- [Section 6 Slides](https://ilxnah.github.io/docker-and-k8s/resources/slides-docker-compose.pdf)
- [Cheat Sheet - Docker Compose](https://ilxnah.github.io/docker-and-k8s/resources/Cheat-Sheet-Docker-Compose.pdf)
