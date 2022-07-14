.PHONY: help
.DEFAULT_GOAL := help
SHELL := /bin/bash

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

install: ## Установка зависимостей Composer
	docker-compose exec app composer install --no-interaction --prefer-dist
