# User Documentation

## Services

The project provides three services:

* **NGINX**: handles HTTPS connections.
* **WordPress**: provides the website and administration interface.
* **MariaDB**: stores the WordPress database.

The services are connected together automatically by Docker Compose.

---

## Starting the project

From the root of the repository:

Provide the .env, either by copying and filling the example.env or moving a secret folder and running

```bash
make .env
```

then run

```bash
make
```

This builds the images if necessary and starts all services.

To start the project without rebuilding:

```bash
make up
```

Once started, the website is available at:

```text
https://emaigne.42.fr
```

If the domain does not work, make sure `/etc/hosts` contains:

```text
127.0.0.1 emaigne.42.fr
```

Since the project uses a self-signed certificate, the browser may show a certificate warning. This is expected.

---

## WordPress

The main website is available at:

```text
https://emaigne.42.fr
```

The WordPress administration panel is available at:

```text
https://emaigne.42.fr/wp-admin
```

Use the WordPress administrator credentials defined in the environment configuration to log in.

---

## Stopping the project

To stop the containers:

```bash
make down
```

This removes the containers but keeps the persistent data.

To completely reset the project:

```bash
make fclean
```

This also removes the Docker volumes and the stored MariaDB/WordPress data.

**Do not use `make fclean` unless you want to delete the existing project data.**

---

## Credentials

The credentials are stored in the `secrets/` directory:

```text
secrets/
├── credentials.txt
├── db_password.txt
├── db_root_password.txt
├── wp_root_password.txt
└── wp_user_password.txt
```

The WordPress configuration is generated from these values and the variables in:

```text
srcs/.env
```

Do not share or commit these files if they contain real passwords.

---

## Checking the Services

Check that all containers are running:

```bash
docker ps
```

Or use:

```bash
docker compose -f srcs/docker-compose.yml ps
```

The three services should be running:

```text
nginx
wordpress
mariadb
```

To see the logs:

```bash
docker compose -f srcs/docker-compose.yml logs
```

To follow the logs in real time:

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

You can also check one service at a time:

```bash
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
```

If all three containers are running and the website loads at `https://emaigne.42.fr`, the stack is working correctly.

---

## Quick Commands

| Command                                             | What it does                          |
| --------------------------------------------------- | ------------------------------------- |
| `make`                                              | Build and start the project           |
| `make up`                                           | Start the project                     |
| `make down`                                         | Stop the project, keep data           |
| `make fclean`                                       | Stop and completely clean the project |
| `docker ps`                                         | Show running containers               |
| `docker compose -f srcs/docker-compose.yml ps`      | Show service status                   |
| `docker compose -f srcs/docker-compose.yml logs -f` | Show live logs                        |
