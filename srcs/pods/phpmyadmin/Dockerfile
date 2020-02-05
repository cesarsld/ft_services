FROM alpine:latest

RUN apk update && apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN apk add php7 php7-fpm php7-opcache php7-zlib php7-mbstring php7-session bash

RUN wget --no-check-certificate -c https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz; \
        tar zxvf phpMyAdmin-4.9.0.1-english.tar.gz;\
        mv phpMyAdmin-4.9.0.1-english /www; \
        unlink *.tar.gz

COPY config.inc.php /www/config.inc.php


# RUN rc-service lighttpd start && rc-update add lighttpd default

CMD ["php", "-S", "0.0.0.0:5000", "-t", "/www/"]

