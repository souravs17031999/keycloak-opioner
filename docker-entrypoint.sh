#!/usr/bin/env bash

source /env.sh

source /wait-for-db-server.sh

cd opt && bash bin/kc.sh --verbose start