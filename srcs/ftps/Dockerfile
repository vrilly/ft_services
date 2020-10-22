FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY vsftpd.conf /etc/vsftpd.conf
COPY telegraf.conf /etc/telegraf.conf
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
