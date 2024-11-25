#!/bin/sh

# Initialize MariaDB data directory
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MySQL in background for initialization
mysqld_safe --datadir=/var/lib/mysql &
sleep 10

# Wait for MySQL to be ready
while ! mysqladmin ping --silent; do
    sleep 1
done

# First time setup
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop background MySQL
mysqladmin shutdown

# Start MySQL in foreground
exec mysqld --user=mysql --console --bind-address=0.0.0.0