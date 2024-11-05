FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y mariadb-server
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/script.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENV SQL_DATABASE=wordpress \
    SQL_USER=wordpress \
    SQL_PASSWORD=wordpress_pwd \
    SQL_ROOT_PASSWORD=root_pwd
EXPOSE 3306
ENTRYPOINT ["/docker-entrypoint.sh"]
