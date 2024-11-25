# Variables
DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_PATH = /home/tmekhzou42/data

all: down
	@mkdir -p $(DATA_PATH)
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@chmod 777 $(DATA_PATH)/mariadb
	@chmod 777 $(DATA_PATH)/wordpress
	@$(DOCKER_COMPOSE) up --build

down:
	@$(DOCKER_COMPOSE) down --volumes
	@docker system prune -a -f
	@docker volume rm -f wordpress mariadb || true
	@docker network prune -f
delete:
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*

stop:
	@$(DOCKER_COMPOSE) stop

status:
	@echo "\nDOCKER STATUS:\n"
	@docker ps
	@echo "\nVOLUMES:\n"
	@docker volume ls
	@echo "\nNETWORKS:\n"
	@docker network ls

re: down delete all

.PHONY: all down delete stop status re