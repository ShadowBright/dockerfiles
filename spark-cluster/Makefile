REPO=adambplattner/docker-spark-cluster
ORG=adambplattner
NAME=spark-cluster
BUILD ?=$(shell cat LATEST)
LATEST ?=$(shell cat LATEST)



build: ## Build docker image
	./config/build.sh

.PHONY: start
start: ## start spark cluster
	./config/start.sh

stop: ## stop spark cluster
	./config/stop.sh

ssh: ## ssh spark master
	./config/ssh.sh

log: ## docker compose errors
	./config/logs.sh

test: ## run pie spark example 
	docker exec -it spark-master /bin/bash -lic "/tmp/config/test_spark.sh"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
