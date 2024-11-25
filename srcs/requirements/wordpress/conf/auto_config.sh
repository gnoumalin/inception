#!/bin/bash
set -e

echo "Waiting for MariaDB..."
for i in {1..30}; do
    if mysqladmin ping -h mariadb -u"${SQL_USER}" -p"${SQL_PASSWORD}" --silent; then
        echo "MariaDB is ready!"
        break
    fi
    echo "Waiting for MariaDB... attempt $i/30"
    sleep 5
done

cd /var/www/wordpress

# Check if WordPress core files need to be downloaded
if [ ! -f "index.php" ]; then
    echo "Installing WordPress..."
    wp core download --allow-root
fi

# Check if WordPress needs to be configured
if [ ! -f "wp-config.php" ]; then
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
fi

echo "Setting correct permissions..."
find /var/www/wordpress -type d -exec chmod 755 {} \;
find /var/www/wordpress -type f -exec chmod 644 {} \;
chown -R www-data:www-data /var/www/wordpress

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F