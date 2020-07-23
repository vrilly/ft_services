FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
