NAME		= inception

COMPOSE		= docker compose -f srcs/docker-compose.yml

.env:
	cp ./secrets/.env ./srcs/.env
	for file in credentials.txt db_password.txt db_root_password.txt wp_root_password.txt wp_user_password.txt; do \
		printf '%s\n' "$$(cat ./secrets/$$file)" >> srcs/.env; \
	done

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
	sudo rm -rf ./secrets
	sudo rm -rf /home/$(USER)/data/wordpress

.PHONY: all down up fclean