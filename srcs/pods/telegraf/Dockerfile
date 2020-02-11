# FROM Image : alpine
FROM alpine:latest

# Install telegraf for monitoring
RUN mkdir /etc/telegraf \
&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz \
&& tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz \
&& chmod +x telegraf/* \
&& cp telegraf/telegraf /usr/bin/ \
&& rm -rf *.tar.gz* telegraf/ 

COPY telegraf.conf /etc/telegraf/telegraf.conf
COPY start.sh .

EXPOSE 4999
RUN chmod +x /start.sh
CMD ./start.sh