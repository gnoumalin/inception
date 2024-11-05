#!/bin/bash

# Exit on error
set -e

# Wait for database to be ready
echo "Waiting for MariaDB..."
while ! mysqladmin ping -h"mariadb" --silent; do
    sleep 1
done

# Create wp-config.php
echo "Creating WordPress configuration..."
wp config create --allow-root \
    --dbname="$SQL_DATABASE" \
    --dbuser="$SQL_USER" \
    --dbpass="$SQL_PASSWORD" \
    --dbhost=mariadb:3306 \
    --path='/var/www/wordpress'

# Install WordPress if not already installed
if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    wp core install --allow-root \
        --url=https://tmekhzou.42.fr \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path='/var/www/wordpress'
    wp user create "$WP_USER" "$WP_EMAIL" \
        --role=editor \
        --user_pass="$WP_PWD" \
        --path='/var/www/wordpress' \
        --allow-root
fi

exec php-fpm7.3 -F