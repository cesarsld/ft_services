# # FROM Image : alpine
# FROM alpine:latest
# # Installation
# RUN apk update \
# && apk add mariadb mariadb-client && apk add --no-cache --upgrade bash
# # Copy initialisation script
# COPY ./init_docker.sh .
# COPY ./init_mysql.sh .
# COPY ./wordpress.sql .
# # Add permission
# RUN chmod 777 init_docker.sh
# RUN chmod 777 init_mysql.sh
# # Start configuration script
# CMD ./init_docker.sh

  
FROM alpine:latest

RUN apk update && \
	apk add mysql mysql-client && \
	addgroup mysql mysql && \
	rm -rf /var/cache/apk/*

COPY scripts/start.sh /bin/start.sh
COPY files/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/bin/start.sh"]