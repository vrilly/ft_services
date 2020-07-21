FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY vsftpd.conf /etc/vsftpd.conf
COPY launch.sh /usr/bin/launch.sh
CMD ["/bin/sh", "/usr/bin/launch.sh"]
