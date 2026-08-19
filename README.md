*This project has been created as part of the 42 curriculum by emaigne.*

# Inception

## Description

**Inception** is a system administration project from the 42 curriculum focused on containerization using Docker. The objective is to build a small infrastructure composed of multiple isolated services communicating through Docker networking while following security and best practices.

The mandatory part of the project consists of deploying the following services:

- **NGINX** as the only entry point to the infrastructure, configured with TLS.
- **WordPress** running with PHP-FPM.
- **MariaDB** as the database server used by WordPress.

Each service runs inside its own Docker container built from a dedicated Dockerfile instead of relying on pre-built images. The infrastructure is orchestrated with Docker Compose and stores persistent data using Docker volumes.

The project aims to provide hands-on experience with:
- Docker image creation
- Container orchestration
- Service isolation
- Persistent storage
- Networking
- Environment configuration
- Secure deployment practices

---

## Project Architecture

```
                 HTTPS
                   │
                   ▼
              +-----------+
              |   NGINX   |
              +-----------+
                    │
                    ▼
             +---------------+
             |   WordPress   |
             |   PHP-FPM     |
             +---------------+
                    │
                    ▼
             +---------------+
             |   MariaDB     |
             +---------------+

        Docker Network
        Docker Volumes
```

---

## Project Design

### Docker

Docker provides lightweight containers that package an application together with its dependencies. Each service executes in an isolated environment while sharing the host operating system kernel.

For this project, Docker allows:
- independent services
- reproducible environments
- simplified deployment
- clean separation of responsibilities

---

### Project Sources

The infrastructure is composed of:

- Docker Compose
- Dockerfiles for each service
- NGINX configuration
- WordPress configuration
- MariaDB initialization
- Shell scripts used during container startup
- Docker volumes for persistent data

---

### Main Design Choices

- One container per service.
- No pre-configured Docker images were used aside from debian:bookworm.
- Communication between containers occurs only through an internal Docker network named inception for this exercise.
- Persistent application data is stored inside Docker volumes.
- Configuration values are supplied through environment variables.
- TLS is terminated by NGINX, making it the single public entry point.

---

## Technical Comparisons

### Virtual Machines vs Docker

| Virtual Machines | Docker |
|------------------|---------|
| Include a complete guest operating system | Share the host kernel |
| Higher resource usage | Lightweight |
| Slower startup | Starts almost instantly |
| Better for complete OS virtualization | Better for application deployment |
| Larger storage footprint | Smaller images |

Docker is preferred for this project because it provides isolated environments while remaining lightweight and fast.

---

### Secrets vs Environment Variables

#### Environment Variables

Environment variables are simple key-value pairs passed to applications.

Advantages:
- easy to configure
- suitable for non-sensitive configuration
- supported by Docker Compose

Disadvantages:
- visible inside containers
- can accidentally appear in logs or process listings

#### Docker Secrets

Docker Secrets are intended for sensitive information such as passwords and certificates.

Advantages:
- encrypted management
- restricted access
- safer credential handling

Disadvantages:
- mainly designed for Docker Swarm
- more complex than required for this project

For the mandatory project, environment variables provide a practical configuration mechanism, although Docker Secrets are the preferred solution for production deployments, here the .env will be intialized from the data in the ./secrets folder.

---

### Docker Network vs Host Network

#### Docker Network

Containers communicate through an isolated virtual network.

Advantages:
- service isolation
- automatic DNS resolution
- improved security
- avoids port conflicts

#### Host Network

Containers share the host networking stack.

Advantages:
- slightly lower overhead

Disadvantages:
- reduced isolation
- increased security risks
- potential port conflicts

This project uses Docker networking because it isolates services while allowing controlled communication.

---

### Docker Volumes vs Bind Mounts

#### Docker Volumes

Volumes are managed directly by Docker.

Advantages:
- portable
- independent from host directory structure
- easier backups
- recommended for databases

#### Bind Mounts

Bind mounts map a host directory directly into a container.

Advantages:
- useful during development
- immediate file synchronization

Disadvantages:
- dependent on host filesystem
- easier to accidentally modify files
- less portable

Docker volumes are used because they provide persistent storage while remaining independent of the host filesystem. The subject forced us to use named volumes, so we got a mix of those to guarantee they are stored into /home/login/data/[wordpress | mariadb]

---

## Instructions

### Requirements

- Docker
- Docker Compose
- Make

### Clone the repository

```bash
git clone <repository_url>
cd inception
```

### Build the infrastructure

```bash
make
```

### Stop containers

```bash
make down
```

### Remove containers, images, and volumes

```bash
make fclean
```

### Rebuild everything

```bash
make re
```

---

## Services

### NGINX

- HTTPS reverse proxy
- TLS termination
- Single public entry point

### WordPress

- PHP-FPM
- Dynamic web application
- Connects to MariaDB

### MariaDB

- Relational database
- Stores WordPress data
- Persistent storage through Docker volumes

---

## Project Structure

```
.
├── Makefile
├── docker-compose.yml
├── srcs/
│   ├── requirements/
│   │   ├── nginx/
│   │   ├── wordpress/
│   │   └── mariadb/
│   └── .env
└── README.md
```

(The exact structure may vary depending on your implementation.)

---

## Resources

### Docker

- Docker Documentation
  https://docs.docker.com/

- Docker Compose Documentation
  https://docs.docker.com/compose/

- Dockerfile Reference
  https://docs.docker.com/reference/dockerfile/

---

### NGINX

- https://nginx.org/en/docs/

---

### MariaDB

- https://mariadb.com/kb/

---

### WordPress

- https://developer.wordpress.org/

---

### TLS

- https://letsencrypt.org/docs/

---

## AI Usage

Artificial intelligence tools were used exclusively as learning and documentation aids.

AI assisted with:
- improving documentation quality
- clarifying Docker concepts
- comparing virtualization and containerization technologies
- explaining networking, volumes, and configuration mechanisms
- proofreading and improving the readability of the README

The Dockerfiles, configuration files, infrastructure implementation, and project logic were designed, written, tested, and validated manually.

---

## Learning Outcomes

Through this project, the following concepts were practiced:

- Docker image creation
- Docker Compose orchestration
- Container networking
- Persistent storage
- Reverse proxy configuration
- TLS setup
- Linux system administration
- Service isolation
- Infrastructure automation

---

## License

This project was developed as part of the 42 curriculum and is intended for educational purposes.
