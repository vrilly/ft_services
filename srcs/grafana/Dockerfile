FROM alpine
COPY image-setup.sh /tmp/
RUN ["/bin/sh", "/tmp/image-setup.sh"]
COPY grafana.ini /etc/grafana.ini
COPY provision_datasource.yaml /etc/grafana.d/datasources/
COPY provision_dashboards.yaml /etc/grafana.d/dashboards/
COPY dashboards /etc/dashboards/
CMD ["/usr/sbin/grafana-server", "-config", "/etc/grafana.ini", "-homepath", "/usr/share/grafana"]
