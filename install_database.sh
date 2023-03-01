#!/bin/bash

MOODLE_INSTALL_DB=$NGINX_ROOT/admin/cli/install_database.php
NGINX_USER=www-data
PHP=$(which php)

wait-for-it.sh -t 0 $DB_HOST:$DB_PORT -- \
    sudo -u $NGINX_USER $PHP $MOODLE_INSTALL_DB \
        --lang=pt_br \
        --fullname="${FULLNAME}" \
        --shortname="${SHORTNAME}" \
        --adminuser="${ADMIN_USER}" \
        --adminpass="${ADMIN_PASSWORD}" \
        --adminemail="${ADMIN_EMAIL}" \
        --agree-license

