#!/usr/bin/env bash
echo "--------------- SETTING KEYCLOAK ENVIRONMENT VARIABLES ------------------"

if [ -z $KC_DB_USERNAME || -z $KC_DB_PASSWORD ]; then 
    echo "KC ADMIN CREDENTIALS NOT PROVIDED !!!, CANNOT PROCEED FURTHER .... EXITING"
    exit 100
fi 

if [ -z $DATABASE_URL ]; then 
    echo "KC POSTGRES DB URI NOT PROVIDED !!!, CANNOT PROCEED FURTHER .... EXITING"
    exit 100
fi 

# extract JDBC params by parsing DB POSTGRES URI 
pg_proto="$(echo $DATABASE_URL | grep :// | sed -e's,^\(.*://\).*,\1,g')"
pg_url="$(echo ${DATABASE_URL/$pg_proto/})"
pg_user="$(echo $pg_url | grep @ | cut -d@ -f1 | grep : | cut -d: -f1)"
pg_pass="$(echo $pg_url | grep : | cut -d: -f2 | grep @ | cut -d@ -f1)"
export pg_host="$(echo $pg_url | grep @ | cut -d@ -f2 | grep : | cut -d: -f1)"
pg_db="$(echo $pg_url | grep / | cut -d/ -f2-)"

echo "  PGHOST: $pg_host"

export KC_DB_URL="jdbc:postgresql://${pg_host}/${pg_db}"
export KC_DB_USERNAME=${pg_user}
export KC_DB_PASSWORD=${pg_pass}

export KEYCLOAK_ADMIN=${KC_ADMIN_USERNAME}
export KEYCLOAK_ADMIN_PASSWORD=${KC_ADMIN_PASSWORD}
export KC_HTTPS_KEY_STORE_PASSWORD=${KEYSTORE_SECRET}

export KC_HTTPS_PORT=8443
# inject Heroku "PORT" binding as env varible to enable HTTP communication 
# internally since SSL termination happens at heroku load balancers
export KC_HTTP_PORT=$PORT