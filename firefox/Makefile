REPO=adambplattner/docker-spark-cluster
ORG=adambplattner
NAME=spark-cluster
BUILD ?=$(shell cat LATEST)
LATEST ?=$(shell cat LATEST)



build: ## Build docker image
	./config/build.sh

.PHONY: start
start: ## start firefox
	./config/run.sh firefox

stop: ## stop firefox  
	./config/stop.sh
ssh: ## ssh into firefox container
	./config/ssh.sh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
