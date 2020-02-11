FROM alpine:latest

RUN apk update && apk add wget && mkdir /www \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& mv wordpress/* /www

COPY wp-config-tmp.php /www/wp-config.php

EXPOSE 5050
CMD ["php", "-S", "0.0.0.0:5050", "-t", "/www/"]