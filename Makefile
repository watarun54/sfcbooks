DC_DEV = docker-compose
DC_PROD = docker-compose -f docker-compose.production.yml

start-dev:
	@$(DC_DEV) up -d --build

start-prod:
	@$(DC_PROD) up -d --build

build-nocache-dev:
	@$(DC_DEV) build --no-cache

build-nocache-prod:
	@$(DC_PROD) build --no-cache

stop-dev:
	@$(DC_DEV) stop

stop-prod:
	@$(DC_PROD) stop

down-dev:
	@$(DC_DEV) down

down-prod:
	@$(DC_PROD) down

setup-dev:
	@$(DC_DEV) up -d --build
	@$(DC_DEV) run web rails db:create db:migrate db:seed

setup-prod:
	@$(DC_PROD) up -d --build
	@$(DC_PROD) run web rails db:create db:migrate db:seed
