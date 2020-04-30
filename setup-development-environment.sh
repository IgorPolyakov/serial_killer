#!/usr/bin/env bash

docker rm -f serial-killer-postgres
docker run -d --name serial-killer-postgres -p 5432:5432 -e POSTGRES_PASSWORD=123 postgres:12

sleep 2

echo 'CREATE DATABASE serial_killer' | docker exec -i -e PGPASSWORD=123 serial-killer-postgres psql -U postgres
cat ./sql/2020-04-30-create-tables.sql | docker exec -i -e PGPASSWORD=123 serial-killer-postgres psql -U postgres serial_killer
