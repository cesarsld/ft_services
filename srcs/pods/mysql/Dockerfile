FROM alpine:latest

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

RUN apk add openrc --no-cache

CMD sh /srcs/pods/mysql/setup.sh

