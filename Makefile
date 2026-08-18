NAME		= inception

COMPOSE		= docker compose -f srcs/docker-compose.yml

all:
	sudo mkdir -p /home/$(USER)/data/mariadb
	sudo mkdir -p /home/$(USER)/data/wordpress
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

up:
	sudo mkdir -p /home/$(USER)/data/mariadb
	sudo mkdir -p /home/$(USER)/data/wordpress
	$(COMPOSE) up

fclean:
	$(COMPOSE) down -v
	sudo rm -rf /home/$(USER)/data/mariadb
	sudo rm -rf /home/$(USER)/data/wordpress

.PHONY: all up fclean