# srcs/requirements/wordpress/Dockerfile
FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysqli \
    mariadb-client \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/www/wordpress/*

WORKDIR /var/www/wordpress

# Copy configs first
COPY conf/auto_config.sh /usr/local/bin/
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN chmod +x /usr/local/bin/auto_config.sh && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["/bin/bash", "/usr/local/bin/auto_config.sh"]