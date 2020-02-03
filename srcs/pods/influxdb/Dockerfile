
FROM alpine:latest

RUN apk update && apk add influxdb \
&& apk add --no-cache --upgrade bash

CMD influxd run -config /etc/influxdb.conf