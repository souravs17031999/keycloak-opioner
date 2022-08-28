#!/usr/bin/env bash

echo "Keycloak Build start ..."
cd opt

# build configuration
cp keycloak.conf conf/
cp server.keystore conf/

bash bin/kc.sh build