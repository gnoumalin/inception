# Variables
DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_PATH = /home/test/data

all: clean
	@mkdir -p $(DATA_PATH)
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@chmod 777 $(DATA_PATH)/mariadb
	@chmod 777 $(DATA_PATH)/wordpress
	@$(DOCKER_COMPOSE) up --build

down:
	@$(DOCKER_COMPOSE) down

clean: down
	@docker system prune -a -f
	@docker volume prune -f
	@docker network prune -f
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

re: clean all

.PHONY: all down clean stop status re