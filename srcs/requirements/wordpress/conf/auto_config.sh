#!/bin/bash
set -e

echo "Waiting for MariaDB..."
while ! mysqladmin ping -h mariadb --silent; do
    sleep 5
done
echo "MariaDB is ready!"

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download --allow-root
    
    echo "Configuring WordPress..."
    wp config create --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'
    
    echo "Installing WordPress core..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_LOGIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --path='/var/www/wordpress'
    
    echo "Creating additional user..."
    wp user create --allow-root \
        "${WP_USER_LOGIN}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=subscriber

    echo "Setting up theme..."
    wp theme install twentytwentythree --activate --allow-root
    
    echo "Setting permissions..."
    chown -R www-data:www-data /var/www/wordpress
    chmod -R 775 wp-content
    
    echo "WordPress setup completed"
fi

exec php-fpm7.4 -F