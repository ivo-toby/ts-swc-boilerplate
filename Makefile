.PHONY: all test
all: help

## Development

dev: check initdb
	@docker-compose -f docker-compose.local.yml --profile dev up -V

dev-shell: check initdb
	@docker-compose -f docker-compose.local.yml run --service-ports --rm ts-swc-dev bash

build-dev:  ## Build the dev image.
	@docker-compose -f docker-compose.local.yml build ts-swc-dev

initdb: build-dev
	# @docker-compose -f docker-compose.local.yml pull postgres

build-test: ## Build the base image.
	@docker-compose build test

build:
	@docker-compose build ts-swc

lint:  ## Lint code
	@docker-compose run --rm test npm run lint

test: build-test ## Run tests.
	@docker-compose run --rm test npm run test

test-shell: build-test ## Open a shell inside the test container. Useful for development.
	@docker-compose run --service-ports --rm test bash

clean: ## Remove all service containers, orphans and one off containers.1
	@docker-compose down -v --remove-orphans
	@docker-compose rm -v

check:	## Checks if pre-requisites for development are met.
	@which docker &> /dev/null || (echo "ERROR: docker not found in PATH" && exit 1);
	@which docker-compose &> /dev/null || (echo "ERROR: docker-compose not found in PATH" && exit 1);
	@if [ -z $(NPM_TOKEN) ]; then echo "ERROR: Environment variable NPM_TOKEN not set" && exit 1; fi;
	@if [ ! -f "./.env.local" ]; then echo "ERROR: File .env.local not found in $(PWD). \n       Duplicate .env.example and provide needed information." && exit 1; fi;

## Help: Show help and exit.
help:
	@echo "# Makefile Help #"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
