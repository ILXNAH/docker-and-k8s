**What are "Images" (when working with Docker)?**
- Images are blueprints for containers which then are running instances with read and write access.

**Why do we have "Images" and "Containers"? Why not just "Containers"?**
- This concept allows multiple containers to be based on the same image without interfering with each other.

**What does "Isolation" mean in the context of containers?**
- Containers are separated from each other and have no shared data or state by default.

**What's a "Container"?**
- An isolated unit of software which is based on an image. A running instance of that image.

**What are "Layers" in the context of images?**
- Every instruction in an image creates a cacheable layer - layers help with image re-building and sharing.

**What does this command do?** 
`docker build .`
- It builds an image.

**What does this command do?**
`docker run node`
- It creates and runs a container based on the "node" image.

**What's the result of these commands?**
1. docker build -t myimage .
2. docker run --name mycontainer myimage
3. docker stop mycontainer
- An image is created, a container is started and then stopped. Both, image and container, have a name assigned by the developer.

**Assume that these commands were executed:**
1. docker build -t myimage:latest .
2. docker run --name mycontainer --rm myimage
3. docker stop mycontainer
Which of the below commands will fail?
- 1. docker rm mycontainer

**What's the idea behind image tags?**
- An image can have a name and then multiple "versions" of that image attached on the same name.

**Do you have to assign custom image tags and container names?**
- No, Docker auto-assigns names and ids.

**What's a "Volume" (when working with Docker)?**
- A folder / file inside of a Docker container which is connected to some folder outside of the container.

**Which statement is correct?**
- Volumes are managed by Docker, you don't necessarily know where the host folder (which is mapped to a container-internal path) is.

**What's true about Anonymous Volumes?**
- They are removed when a container, that was started with "--rm" is stopped.

**What's the advantage of "Named Volumes"?**
- They survive container removal.

**What's a "Bind Mount"?**
- A path on your host machine, which you know and specified, that is mapped to some container-internal path.

**What's a typical use-case for a "Bind Mount"?**
- You want to provide "live data" to the container (no rebuilding needed).

**Are Anonymous Volumes useless?**
- No, you can use them to prioritize container-internal paths higher than external paths.

**When running containers on your system (via `docker run`): Can these containers communicate with the world wide web?**
- That's correct. By default, your containers (and the apps inside of them) can reach out to the web and send requests.

**How can applications running in a container communicate to your local host machine?**    
- By using the special `host.docker.internal` address

**How can containers communicate with other containers?**
- By manually finding the IP addresses or by using a network

**How can containers communicate with each other if they are in the same network?**
- You can use the container names as addresses

**Does the `docker-compose` command replace the `docker` command?**
- No, both commands can work together

**Which problem does `docker-compose` mainly solve?**
- Annoying repetition of (long) commands

**Which statement is NOT true?**
- docker-compose removes the concept of container images by just focusing on containers

**Which of the following statements is true?**
- With docker-compose, you can define volumes and add them to containers

**Which of the following statements is true?**
- With docker-compose, a default network for all composed containers is created

**Which of the following problems does Kubernetes help with?**
- Deployment of (more complex) containerized applications

**What's a "Kubernetes Cluster"?**
- A network of machines which are split up in Worker and Master Nodes

**What's a "Worker Node"?**
- A machine which hosts running Pods / Containers

**What's a "Pod"?**
- A "shell" for a Container - responsible for running and containing that container (+ any required config and volumes)

