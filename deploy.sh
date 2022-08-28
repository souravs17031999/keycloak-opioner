#!/usr/bin/env bash
set -e 

echo "Starting deployment to Heroku CI/CD....."

if [[ -z $HEROKU_API_KEY ]]; then 
    echo "HEROKU CREDENTIALS NOT PROVIDED !!!, CANNOT PROCEED FURTHER .... EXITING"
    exit 1
fi 

echo "Heroku authentication......"
HEROKU_APPS=$(HEROKU_API_KEY="${HEROKU_API_KEY}" heroku apps)
echo "Heroku container registry login......"
heroku container:login

echo "Listing heroku apps....."
echo $HEROKU_APPS
echo "PROVIDED APP_NAME: ${APP_NAME}"

if [[ "$HEROKU_APPS" =~ .*${APP_NAME}.* ]]; then
    echo "deploying ${APP_NAME} of type: ${APP_TYPE} to production ...."
    heroku container:push ${APP_TYPE} -a ${APP_NAME}
    heroku container:release ${APP_TYPE} -a ${APP_NAME}
    heroku ps:scale ${APP_TYPE}=1 -a ${APP_NAME}
else 
    echo "[WARNING]: NO MATCHING APP NAME FOUND !"
fi 
