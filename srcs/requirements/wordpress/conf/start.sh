#!/bin/bash

sleep 5
until mysqladmin ping \
        -h"mariadb" \
        -u"$SQL_USER" \
        -p"$SQL_PASSWORD" \
        --silent
    do
        sleep 2
    done

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

    wp core install \
        --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path='/var/www/wordpress'

    wp user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=subscriber \
        --allow-root \
        --path='/var/www/wordpress'

    

fi

exec php-fpm8.2 -F