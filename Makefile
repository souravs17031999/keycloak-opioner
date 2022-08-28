export APP_NAME=keycloak-opioner
export APP_TYPE=web

.PHONY: test deploy build 

build:
	@echo "MAKE build ==========================================="
	opioner-commons/docker-flow.sh  

test:
	@echo "MAKE test ==========================================="
	TEST_SUITE_DIR="apitest" \
	opioner-commons/run-tests.sh  

deploy:
	@echo "MAKE heroku_deploy ===========================================" 
	./deploy.sh 