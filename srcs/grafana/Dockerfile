FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY grafana.ini /etc/grafana.ini
CMD ["/usr/sbin/grafana-server", "-config", "/etc/grafana.ini", "-homepath", "/usr/share/grafana"]
