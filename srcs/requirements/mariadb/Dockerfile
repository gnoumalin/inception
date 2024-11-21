# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server dos2unix && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

# Copy and prepare configuration files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY conf/script.sh /docker-entrypoint.sh

# Fix script format and permissions
RUN dos2unix /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]