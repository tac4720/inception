COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/$(USER)/data

all:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	@docker-compose -f $(COMPOSE_FILE) --env-file srcs/.env up --build -d

re:
	@docker-compose -f $(COMPOSE_FILE) --env-file srcs/.env down
	@$(MAKE) all

clean:
	@docker-compose -f $(COMPOSE_FILE) --env-file srcs/.env down
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_DIR)

fclean: clean
	@docker system prune -af

.PHONY: all re clean fclean
