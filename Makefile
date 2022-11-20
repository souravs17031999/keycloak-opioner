export APP_NAME=keycloak-opioner
export APP_TYPE=web

.PHONY: test deploy build 

build:
	@echo "MAKE build ==========================================="
	opioner-commons/docker-flow.sh  

deploy:
	@echo "MAKE heroku_deploy ===========================================" 
	./deploy.sh 

local:
	@echo "MAKE local ==========================================="
	docker-compose up --build  