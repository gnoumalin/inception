FROM debian:bullseye
RUN apt-get update && apt-get install -y nginx
RUN apt install vim curl openssl -y
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=tmekhzou.42.fr/UID=login"
RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Add test page
RUN echo "<h1>Nginx Test Page</h1>" > /var/www/html/index.html

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]