# 8. Laravel & PHP Dockerized Project

## Table of Contents
- [Module Introduction](#module-introduction)
- [Target Setup](#target-setup)
- [Laravel Setup - Building Blocks](#laravel-setup---building-blocks)
- [Adding Application Containers](#adding-application-containers)
  - [Adding an Nginx Web Server](#adding-an-nginx-web-server)
  - [Adding a PHP Interpreter](#adding-a-php-interpreter)
  - [Adding a MySQL Database](#adding-a-mysql-database)
- [Adding Utility Containers](#adding-utility-containers)
  - [Adding a Composer](#adding-a-composer)
    - [Creating Laravel App via Composer](#creating-laravel-app-via-composer)
    - [Launching Only Some Docker Compose Services](#launching-only-some-docker-compose-services)
  - [Adding More Utility Containers](#adding-more-utility-containers)
    - [Artisan](#artisan)
    - [npm](#npm)
- [Bind Mounts and COPY: When To Use What](#bind-mounts-and-copy-when-to-use-what)
- [Module Resources](#module-resources)

# Module Introduction
**Practice: A Laravel & PHP Setup**
- Images, Container, Compose - All in Action
- No Laravel knowledge is required!
- Will learn a couple of new features (docker-compose, interacting of multiple docker files, connecting images ...)

## Target Setup
Tech picked -> build more complex dev env for such app compared to more simplistic NodeJS we did before in the course
- you can use Docker for anything esp. in web tech
- [Laravel Documentation](https://laravel.com/docs/master/documentation)
    - server requirements - a long list:
        - PHP installation is required + additionally also a server separately (as opposed to NodeJS, which does both: app code + server logic building)
            - server itself cannot be built with PHP 
            - instead, a server is needed that handles incoming requests, which triggers the PHP interpreter to run PHP code for the incoming requests
            - possibly also combined with SQL/MongoDB

> Without installing anything except for Docker -- we will be able to write Laravel PHP code and build apps.

### Laravel Setup - Building Blocks
1. **💻 host machine -- 📂 source code folder**
2. **1️⃣ Docker application container -- PHP interpreter**
    - has PHP installed inside
    - has access to source code folder
    - interprets it and generates a response
3. **2️⃣ Docker application container -- web server (nginx)**
    - takes incoming requests
    --> goes to PHP interpreter, lets it generate a response and send it to clients who sent the requests
4. **3️⃣ Docker application container -- MySQL database** 
    - communication set up with PHP interpreter
5. ⚙️ **Docker utility container -- Composer** (= PHP alternative of `npm` for NodeJS; = a package manager)
    - used to create the Laravel application
    - Laravel will use composer to install dependencies
6. **⚙️ Docker utility container -- Laravel Artisan**
    = a command used e.g. to run migrations against the DB & write initial starting data to it
7. **⚙️ Docker utility container -- npm**
    - Laravel uses it for some of its FE logic

## Adding Application Containers

### Adding an Nginx Web Server
- official [nginx image](https://hub.docker.com/_/nginx) + documentation is on Docker Hub
    - mentions internally exposed ports, image variants (e.g. alpine) etc.
- nginx service defined in [`docker-compose.yaml`](/08-laravel-php/docker-compose.yaml) as `server`
- in local project source folder, added folder `nginx` with predefined [`nginx.conf`](/08-laravel-php/nginx/nginx.conf)

### Adding a PHP Interpreter
- using official [PHP image](https://hub.docker.com/_/php) as a basis
- building on top of it a custom [`Dockerfile`](/08-laravel-php/dockerfiles/php.dockerfile)
    - extra extensions installed for Laravel
    - tool `docker-php-ext-install` used to install php extensions/dependencies (`pdo pdo_mysql`)
    - WORKDIR `/var/www/html` will be the folder which will **always hold the final application** (in all containers in this module)
    - there is no entrypoint or CMD instruction defined --> default command/entrypoint from the base image `php:7.4-fpm-alpine` will be executed
        - it is a command which invokes the PHP interpreter = the container is ready to execute PHP code right away

### Adding a MySQL Database
- using official [MySQL image](https://hub.docker.com/_/mysql) from Docker Hub (comparable to previously used MongoDB image)
- runs a database which will be handled by PHP container
- in [`docker-compose.yaml`](/08-laravel-php/docker-compose.yaml) should be defined ENV variables (described in the mysql image doc)
    - set in a separate [`.env`](/08-laravel-php/env/mysql.env) file and link into [`docker-compose.yaml`](/08-laravel-php/docker-compose.yaml)
        - `MYSQL_DATABASE=homestead` & `MYSQL_USER=homestead` --> set as per [Laravel Doc](https://laravel.com/docs/master/documentation)

## Adding Utility Containers

### Adding a Composer
- used internally by Laravel + **used locally to set up a Laravel app**
- built from official [Composer image](https://hub.docker.com/_/composer) on Docker Hub into a custom Dockerfile adding entrypoint
- in `docker-compose.yaml` define:
    - `build:` with the created Dockerfile
    - `volume:` to mirror any built app code from inside the container into local host's source folder `/src`

#### Creating Laravel App via Composer
- install Laravel via Composer Create-Project -- cmd from official doc:
```
composer create-project laravel/laravel {directory} 4.2 --prefer-dist
```
- **run a single utility container from docker-compose** via:
```
docker-compose run --rm composer create-project laravel/laravel . --prefer-dist
```

#### Launching Only Some Docker Compose Services
- inside `.env` file in `/src` folder with generated Laravel app, there is following code block with DB connection info:
```
DB_CONNECTION=sqlite
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=laravel
# DB_USERNAME=root
# DB_PASSWORD=
```
- values should correspond with the ENV vars we set up for MySQL DB previously, i.e.:
```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```
- bring up the services defined with `docker-compose up -d server php mysql`
- define `depends_on:` for `server:` in docker-compose.yaml --> simplify up cmd to `docker-compose up -d server`

### Adding More Utility Containers

#### Artisan 
= Laravel command built with PHP => needs PHP to execute code
- needed to run certain Laravel commands, e.g. to populate DB with initial data
- needs a custom `Dockerfile` --> reusing `php.dockerfile` with the same setup
- needs access to local source code -- since it is executed on the source code --> added bind mount volume
- since `php.dockerfile` does not have **entrypoint**, but it is needed for artisan --> additionally specified directly in `docker-compose.yaml` 

#### npm
```yaml
  npm:
    image: node:14
    working_dir: /var/www/html
    entrypoint: [ "npm" ]
    volumes:
      - ./src:/var/www/html
```

## Bind Mounts and COPY: When To Use What

- instead of using `docker-compose.yaml` definitions of config/source code during development:
```yaml
server:
    image: 'nginx:stable-alpine'
    ports:
      - '8000:80'
    volumes:
      - ./src:/var/www/html
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro
    depends_on:
      - php
      - mysql
```
- you could create a separate `Dockerfile` to copy over snapshots for deploying images independently - without relying on bind mounts:
```dockerfile
FROM nginx:stable-alpine

# Copy snapshot of nginx configuration into image
WORKDIR /etc/nginx/conf.d/
COPY nginx/nginx.conf .
RUN mv nginx.conf default.conf

# Copy snapshot of local project source code into image
WORKDIR /var/www/html
COPY src .
```

## Module Resources
- [Slides Laravel.pdf](https://ilxnah.github.io/docker-and-k8s/resources/slides-laravel.pdf)