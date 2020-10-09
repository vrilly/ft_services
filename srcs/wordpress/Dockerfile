FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY firsttime.sh /usr/bin/firsttime.sh
COPY supervisord.conf /etc/supervisord.conf
CMD ["/bin/sh", "/usr/bin/firsttime.sh"]
