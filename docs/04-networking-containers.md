# 4. Networking: (Cross-)Container Communication

## 📁 Table of Contents

- [Connecting Containers](#connecting-containers)
- [Docker communication / types of requests](#docker-communication--types-of-requests)
  - [Requests from container to host machine](#requests-from-container-to-host-machine)
    - [Cross-container: Creating container networks](#cross-container-creating-container-networks)
      - [Run container & assign it to a network](#run-container--assign-it-to-a-network)
      - [Understanding Docker Network IP Resolving](#understanding-docker-network-ip-resolving)
      - [Docker network drivers](#docker-network-drivers)
- [Module Resources](#module-resources)

---

## Connecting Containers

- Containers & External Networks
- Connecting Containers with **Networks**

## Docker communication / types of requests

1. to www
2. to host machine
3. between containers (e.g. database) / cross-container

### Requests from container to host machine

`mongodb://host.docker.internal:27017/swfavorites`

- use `host.docker.internal` as address domain

### Cross-container: Creating container networks

`docker run --network mynetwork ...`

Within a Docker network, all containers can communicate with each other and IPs are automatically resolved.

#### Run container & assign it to a network

- First, create a network manually:  
  `docker network create favorites-net`

- Then, run/assign a container to it:  
  `docker run -d --name mongodb --network favorites-net mongo`

- Inspect all existing networks:  
  `docker network ls`

Add a second container:

- `docker run --name favorites --network favorites-net -d --rm -p 3000:3000 favorites-node`

- Test with Postman whether they can communicate via GET and POST requests.

#### Understanding Docker Network IP Resolving

- Docker will not replace source code.
- It only detects outgoing requests and resolves the IP for them.

#### Docker network drivers

- Docker networks support different kinds of drivers which influence the behavior of the network.
- Default driver is the `bridge` driver:
  - Provides support for containers to find each other within the same network.

- Driver can be set when creating a network by adding the `--driver` option:

  ```bash
  docker network create --driver bridge my-net
  ```

- `bridge` is the default network driver, so it can be omitted.

- Alternative drivers:
  - **host** — removes isolation between container and host system.
  - **overlay** — allows multiple Docker daemons (i.e., Docker running on different machines) to connect.
  - **macvlan** — assigns a custom MAC address to a container.
  - **none** — disables all networking.
  - **3rd party plugins** — varies.

## Module Resources

- [slides-networking.pdf](/resources/slides-networking.pdf)
- [Cheat-Sheet-Networks-Requests.pdf](/resources/Cheat-Sheet-Networks-Requests.pdf)