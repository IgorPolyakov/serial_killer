#!/usr/bin/env bash


cd kekend
VER=`mix app.version`
MIX_ENV=prod mix distillery.release
ssh fox@45.142.213.36 mkdir -p deploy/releases/$VER
scp _build/prod/rel/serial_killer/releases/$VER/serial_killer.tar.gz \
fox@45.142.213.36:deploy/releases/$VER
ssh fox@45.142.213.36 tar -x -f ~/deploy/releases/$VER/serial_killer.tar.gz -C ~/kekend
