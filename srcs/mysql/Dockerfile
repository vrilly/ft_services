FROM alpine
COPY image-setup.sh /tmp/
COPY my.cnf /etc/my.cnf
COPY launch.sh /launch.sh
RUN ["/bin/sh", "/tmp/image-setup.sh"]
CMD ["/bin/sh", "/launch.sh"]
