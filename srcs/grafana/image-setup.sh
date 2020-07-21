#!/bin/sh

echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk add grafana
mkdir -p /etc/grafana.d/datasources
mkdir -p /etc/grafana.d/dashboards
mkdir -p /etc/grafana.d/notifiers
