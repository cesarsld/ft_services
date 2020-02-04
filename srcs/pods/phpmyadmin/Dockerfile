FROM alpine:latest

RUN apk update && apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN apk add openrc
COPY ./lighttpd.conf .
COPY ./mod_fastcgi.conf .
COPY ./setup.sh .

RUN rm /etc/lighttpd/lighttpd.conf && rm /etc/lighttpd/mod_fastcgi.conf
RUN mv /lighttpd.conf /etc/lighttpd/ && mv /mod_fastcgi.conf /etc/lighttpd

# RUN rc-service lighttpd start && rc-update add lighttpd default
RUN rc-update add lighttpd default
CMD sh /setup.sh