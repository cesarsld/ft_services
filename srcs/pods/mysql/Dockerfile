# FROM Image : alpine
FROM alpine:latest
# Installation
RUN apk update \
&& apk add mariadb mariadb-client && apk add --no-cache --upgrade bash
# Copy initialisation script
COPY ./init_docker.sh .
COPY ./init_mysql.sh .
COPY ./wordpress.sql .
# Add permission
RUN chmod 777 init_docker.sh
RUN chmod 777 init_mysql.sh
# Start configuration script
CMD ./init_docker.sh