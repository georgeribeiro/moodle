#!/bin/bash

MOODLE_CFG_TMPL=/config.php
MOODLE_CFG_FILE=$NGINX_ROOT/config.php
NGINX_USER=www-data

set -ex

sed \
    -e "s|\${WWWROOT}|${WWWROOT}|g" \
    -e "s|\${DATAROOT}|${DATAROOT}|g" \
    -e "s|\${DB_TYPE}|${DB_TYPE}|g" \
    -e "s|\${DB_HOST}|${DB_HOST}|g" \
    -e "s|\${DB_PORT}|${DB_PORT}|g" \
    -e "s|\${DB_NAME}|${DB_NAME}|g" \
    -e "s|\${DB_USERNAME}|${DB_USERNAME}|g" \
    -e "s|\${DB_PASSWORD}|${DB_PASSWORD}|g" \
    -e "s|\${DB_PREFIX}|${DB_PREFIX:-mdl_}|g" \
    -e "s|\${SSLPROXY}|${SSLPROXY:-0}|g" \
    $MOODLE_CFG_TMPL > $MOODLE_CFG_FILE

chown -R $NGINX_USER:$NGINX_USER $NGINX_ROOT

exec "$@"

