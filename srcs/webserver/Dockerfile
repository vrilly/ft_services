FROM alpine
COPY image-setup.sh /tmp/
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
