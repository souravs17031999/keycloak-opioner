#!/usr/bin/env bash
echo "------------------------- WAITING FOR SERVER FOR POSTGRES DB -------------------------"

TIMEOUT=120
while ! pg_isready -h $pg_host
do  
    if [[ $TIMEOUT -eq 0 ]]; then 
        echo ">>>>>>>>>>>>> Didn't Found the HOST of the PG CLUSTER after 120 seconds"
        exit 100
    fi
    TIMEOUT=$(($TIMEOUT-1))
    echo -n "waiting for database to start...., remaining discovery time: $TIMEOUT seconds"
    sleep 1
done

echo "------------------------- POSTGRES DB SERVER succesfully discovered and ready to accept connections -------------------------"