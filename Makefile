SHELL := /bin/bash

ifneq ("$(wildcard .env)","")
    include .env
else
    $(shell touch .env)
endif

.PHONY: lint init update help

# Default target executed when no arguments are given to make.
all: help

lint:
	pre-commit run --all-files

init:
	npm install
	make update

	pre-commit install
	pre-commit autoupdate

update:
	npm install -g npm
	npm install -g npm-check-updates
	ncu --upgrade --packageFile package.json
	npm update -g
	npm install

######################
# HELP
######################

help:
	@echo '===================================================================='
	@echo 'lint               - run all code linters and formatters'
	@echo 'init               - create environments for Python, NPM and pre-commit and install dependencies'
