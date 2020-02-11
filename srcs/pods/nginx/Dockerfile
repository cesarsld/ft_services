FROM alpine:latest

# update && install nginx && bash && openssl && folder for nginx pid
RUN apk update && apk add nginx \
&& apk add --no-cache --upgrade bash \
&& apk add openssl openssh && mkdir -p var/run/nginx

# create user for nginx && generate nginx folder && add permissions
RUN adduser -D -g 'www' www \
&& mkdir /www && chown -R www:www /var/lib/nginx \
&& chown -R www:www /www

# SSL
RUN mkdir /etc/nginx/ssl \
&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/www.pem -keyout /etc/nginx/ssl/www.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=cjaimes/CN=ft_services"

# Nginx config
RUN rm /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./start.sh /start.sh
COPY ./sshd_config /etc/ssh/
COPY ./ssh_host_rsa_key /etc/ssh/

RUN chmod 600 /etc/ssh/ssh_host_* && chmod +x /start.sh

EXPOSE 80 443 6666
# Start nginx
ENTRYPOINT sh /start.sh