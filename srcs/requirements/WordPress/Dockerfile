FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install wget
RUN apt-get install -y php7.3\
php-fpm\
php-mysql\
mariadb-client

RUN mkdir -p /run/php
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY conf/php.ini /etc/php/7.3/fpm/php.ini

RUN wget https://fr.wordpress.org/wordpress-6.6.2-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.6.2-fr_FR.tar.gz && rm -rf wordpress-6.6.2-fr_FR.tar.gz
RUN chown -R www-data:www-data /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
ENV WP_ADMIN_USER=wpadmin \
    WP_ADMIN_PWD=admin_pwd \
    WP_ADMIN_EMAIL=tmekhzou@42.fr \
    WP_USER=user42 \
    WP_PWD=user42_pwd \
    WP_EMAIL=random@42.fr
EXPOSE 9000

CMD ["php-fpm7.3", "-F"]
