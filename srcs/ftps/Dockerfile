FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY vsftpd.conf /etc/vsftpd.conf
CMD /usr/sbin/vsftpd
