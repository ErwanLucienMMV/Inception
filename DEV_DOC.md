# Developer Documentation

## Setup

### Requirements

You need:

* Docker
* Docker Compose
* Make
* Git

Clone the repo:

```bash
git clone https://github.com/ErwanLucienMMV/Inception.git
cd Inception
```

The project uses three containers:

* `nginx`
* `wordpress`
* `mariadb`

### Configuration

Secrets are stored in:

```text
secrets/
├── credentials.txt
├── db_password.txt
├── db_root_password.txt
├── wp_root_password.txt
└── wp_user_password.txt
```

secrets that aren't pushed in public for obvious reasons

The environment file is:

```text
srcs/.env
```

It contains the database, WordPress and domain configuration.

The domain used by the project is `emaigne.42.fr`. Add it to `/etc/hosts` if it does not resolve:

```text
127.0.0.1 emaigne.42.fr
```

The project expects the host data directories to exist:

```text
/home/emaigne/data/mariadb
/home/emaigne/data/wordpress
```

If running the project with another user, update the paths in `docker-compose.yml`.

---

## Build and Run

The easiest way to build and start everything:

copy the ./secrets to the root of said directory, and run
```bash
make .env
```

or copy and create values for all the fields provided in examples.env

```bash
make
```

This creates the data directories and runs:

```bash
docker compose -f srcs/docker-compose.yml up --build
```

To start without rebuilding:

```bash
make up
```

To stop the containers:

```bash
make down
```

---

## Useful Commands

Check running containers:

```bash
docker ps
```

Check Compose status:

```bash
docker compose -f srcs/docker-compose.yml ps
```

View logs:

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

Logs for one service:

```bash
docker compose -f srcs/docker-compose.yml logs -f nginx
docker compose -f srcs/docker-compose.yml logs -f wordpress
docker compose -f srcs/docker-compose.yml logs -f mariadb
```

Open a shell inside a container:

```bash
docker exec -it nginx bash
docker exec -it wordpress bash
docker exec -it mariadb bash
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume>
```

---

## Data Persistence

There are two persistent volumes:

```text
mariadb
wordpress
```

They contain:

* MariaDB data → `/home/emaigne/data/mariadb`
* WordPress files → `/home/emaigne/data/wordpress`

The data survives `make down` because the volumes are not removed.

To completely reset the project:

```bash
make fclean
```

This runs `docker compose down -v` and removes the data directories.

**Warning:** `make fclean` deletes the database and WordPress data.

---

## Development Workflow

After changing a Dockerfile or build configuration:

```bash
make
```

After changing runtime configuration, restart the required service:

```bash
docker compose -f srcs/docker-compose.yml restart <service>
```

When finished:

```bash
make down
```
