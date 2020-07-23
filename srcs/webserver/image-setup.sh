#!/bin/sh

apk add nginx openssh openssl
rm /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx
mkdir -p /usr/share/ssl/certs
cd /usr/share/ssl/certs
openssl req -x509 -sha256 -nodes -days 365 -subj "/CN=HTTP" -newkey rsa:2048 -keyout nginx.key -out nginx.pem
