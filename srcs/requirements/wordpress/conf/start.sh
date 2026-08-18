#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    echo "[INFO] WordPress is not initialized."

    wp core download \
        --allow-root \
        --locale=fr_FR \
        --path='/var/www/wordpress'

    wp config create \
        --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost='mariadb:3306' \
        --path='/var/www/wordpress'

fi

exec php-fpm8.2 -F