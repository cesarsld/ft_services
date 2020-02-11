  
FROM alpine:latest

RUN apk upgrade && \
    printf '%s\n' \
      '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
      >> /etc/apk/repositories && \
    apk update && \
	apk add openssl && \
    apk add pure-ftpd@testing="1.0.49-r0" && \
    rm -rf /var/cache/apk/*

# COPY pure-ftpd.pem /etc/ssl/private/
COPY start-tmp.sh /bin/start-tmp.sh
RUN chmod +x /bin/start-tmp.sh

EXPOSE 21 21000
ENTRYPOINT ["/bin/start-tmp.sh"]