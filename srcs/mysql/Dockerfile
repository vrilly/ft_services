FROM alpine
COPY image-setup.sh /tmp/
COPY my.cnf /etc/mysql/my.cnf
RUN ["/bin/sh", "/tmp/image-setup.sh"]
CMD /usr/bin/mysqld
