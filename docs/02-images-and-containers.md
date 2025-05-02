# 2. Images & Containers

## 📁 Table of Contents

- [Images vs Containers](#images-vs-containers)
  - [Image](#image)
  - [Container](#container)
    - [Create Your Own Image](#create-your-own-image)
    - [Additional Quick Side-Note](#additional-quick-side-note)
    - [Images Are Read-Only](#images-are-read-only)
    - [Images Are Layer-Based](#images-are-layer-based)
    - [Container Layer Is Read-Write](#container-layer-is-read-write)
- [Managing Images & Containers](#managing-images--containers)
  - [Stopping & Restarting Containers](#stopping--restarting-containers)
  - [Attached & Detached Containers](#attached--detached-containers)
  - [Entering Interactive Mode](#entering-interactive-mode)
  - [Deleting Images & Containers](#deleting-images--containers)
    - [Remove Containers](#remove-containers)
    - [Remove Images](#remove-images)
  - [Inspecting Images](#inspecting-images)
  - [Copying Files Into & From a Container](#copying-files-into--from-a-container)
  - [Naming & Tagging Containers and Images](#naming--tagging-containers-and-images)
  - [Sharing Images](#sharing-images)
    - [Sharing via Docker Hub or Private Registry](#sharing-via-docker-hub-or-private-registry)
    - [Pushing Images to Docker Hub](#pushing-images-to-docker-hub)
    - [Pulling & Using Shared Images](#pulling--using-shared-images)
- [Module Resources](#-module-resources)

---

## Images vs Containers

### Image

- Template for container which includes the app code + tools/runtimes.
- Used to **hold all the logic and code** the container needs.
- Download an image from Docker Hub via:

```bash
docker run node
```

- Check exited containers:

```bash
docker ps -a
```

- Start an interactive session:

```bash
docker run -it <IMAGE>
```

---

### Container

- Running unit of software — running instance of an image.
- Multiple containers can be based on a single image.

#### Create Your Own Image

- Write your own `Dockerfile` based on another image.
- Container contains environment + code.
- `CMD` executes when container is started:
  - If no `CMD`, base image's `CMD` will run.
  - No base + no `CMD` = error.
  - `CMD` must be last in `Dockerfile`.
- `EXPOSE` is optional and documentation-only.

#### Additional Quick Side-Note

- For Docker commands requiring IDs, you can use **shortened** versions — only unique first characters are needed.

Example:

```bash
docker run abc
```
instead of full ID.

#### Images Are Read-Only

- If source code changes, **image must be rebuilt**.
- Images are immutable after build.

#### Images Are Layer-Based

- Only changed layers (and below) are rebuilt.
- Docker caches instruction results.
- **Layer-based architecture** speeds up builds.

#### Container Layer Is Read-Write

- While image is read-only, running container has a writable layer.

---

## Managing Images & Containers

### Images

- Tag an image:

```bash
docker tag source target
```

- List images:

```bash
docker images
```

- Inspect an image:

```bash
docker image inspect <ID>
```

### Containers

- Set container name:

```bash
docker run --name containername <ID>
```

- List running containers:

```bash
docker ps
```

- Remove container:

```bash
docker rm <NAME/ID>
```

---

### Stopping & Restarting Containers

- View all containers (stopped + running):

```bash
docker ps -a
```

- Start existing container:

```bash
docker start <NAME/ID>
```

---

### Attached & Detached Containers

- **Attached run:**

```bash
docker run <IMAGE>
```

- **Detached run:**

```bash
docker run -d <IMAGE>
```

- Attach to running container:

```bash
docker attach <NAME/ID>
```

- See logs:

```bash
docker logs <NAME/ID>
```

- Follow logs:

```bash
docker logs -f <NAME/ID>
```

---

### Entering Interactive Mode

- Start container interactively:

```bash
docker run -it <IMAGE>
```

- Attach interactively to started container:

```bash
docker start -ai <NAME/ID>
```

---

### Deleting Images & Containers

#### Remove Containers

- Remove specific containers:

```bash
docker rm <NAME1> <NAME2>
```

- Remove all stopped containers:

```bash
docker container prune
```

- Auto-remove container after stop:

```bash
docker run --rm <IMAGE>
```

---

#### Remove Images

- Remove image:

```bash
docker rmi <IMAGE>
```

- Remove all unused images:

```bash
docker image prune -a
```

---

### Inspecting Images

- Inspect an image's metadata:

```bash
docker image inspect <ID>
```

Shows info like:

- Full ID
- Ports
- Environment variables
- Entrypoint
- OS
- Layers

---

### Copying Files Into & From a Container

- Copy files between container and host:

```bash
docker cp src_path container_name:dest_path
docker cp container_name:src_path dest_path
```

Usually used for:

- Updating configuration files
- Extracting logs

---

### Naming & Tagging Containers and Images

- Set container name at run:

```bash
docker run --name mycontainer <IMAGE>
```

- Tag image:

```bash
docker build --tag myimage:tag .
```

- Retag existing image:

```bash
docker tag old-name new-name
```

---

### Sharing Images

#### Sharing via Docker Hub or Private Registry

- Push to Docker Hub:

```bash
docker push account/image-name
```

- Pull from Docker Hub:

```bash
docker pull account/image-name
```

- For private registries, specify host:

```bash
docker pull my-registry.com/account/image-name
```

---

#### Pushing Images to Docker Hub

- Retag image to match Docker Hub repo name.
- Push the image:

```bash
docker push username/image-name
```

- Authenticate:

```bash
docker login
```

---

#### Pulling & Using Shared Images

- Pull:

```bash
docker pull username/image-name
```

- Or automatically pull if needed on run:

```bash
docker run username/image-name
```

---

## 📚 Module Resources

- [📄 Cheat Sheet: Images & Containers](https://ilxnah.github.io/docker-and-k8s/resources/Cheat-Sheet-Images-Containers.pdf)
- [📄 Slides: Images & Containers](https://ilxnah.github.io/docker-and-k8s/resources/slides-images-containers.pdf)

---
