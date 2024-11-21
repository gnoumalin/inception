# srcs/requirements/mariadb/conf/script.sh
#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB server
    mysqld --user=mysql &
    
    # Wait for MariaDB to be ready
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 2
    done

    # Configure MariaDB
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # Clean shutdown
    mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
fi

# Start MariaDB
exec mysqld --user=mysql