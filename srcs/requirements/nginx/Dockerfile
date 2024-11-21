FROM debian:bullseye
RUN apt-get update && \
    apt-get install -y nginx vim curl openssl && \
    mkdir -p /etc/nginx/ssl /var/run/nginx && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=tmekhzou.42.fr/UID=login" && \
    rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]