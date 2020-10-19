#!/bin/sh

apk add nginx openssh openssl supervisor
rm /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx
mkdir -p /usr/share/ssl/certs
cd /usr/share/ssl/certs
openssl req -x509 -sha256 -nodes -days 365 -subj "/CN=HTTP" -newkey rsa:2048 -keyout nginx.key -out nginx.pem
cd
ssh-keygen -A
chown root.root /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
passwd -u root
