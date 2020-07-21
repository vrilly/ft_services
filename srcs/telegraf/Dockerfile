FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY telegraf.conf /etc/telegraf.conf
CMD ["/usr/bin/telegraf", "-config", "/etc/telegraf.conf", "-config-directory", "/etc/telegraf.conf.d"]
