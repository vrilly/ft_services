FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
CMD ["/usr/sbin/influxd", "-config", "/etc/influxdb.conf"]
