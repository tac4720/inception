COMPOSE_FILE = srcs/docker-compose.yml

all:
	@docker-compose -f $(COMPOSE_FILE) --env-file srcs/.env up --build -d

down:
	@docker-compose -f $(COMPOSE_FILE) --env-file srcs/.env down

re:
	@$(MAKE) down
	@$(MAKE) all

clean:
	@$(MAKE) down
	@docker system prune -af --volumes

.PHONY: all down re clean
