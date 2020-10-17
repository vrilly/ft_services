FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
COPY config.inc.php /var/www/phpmyadmin/config.inc.php
CMD ["/usr/bin/supervisord"]
