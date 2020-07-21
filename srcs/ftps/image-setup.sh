#!/bin/sh

apk add vsftpd openssl curl jq
touch /var/log/ftp.log
chown ftp.ftp /var/log/ftp.log
chmod 777 /var/log/ftp.log
mkdir -p /usr/share/ssl/certs
cd /usr/share/ssl/certs
openssl req -x509 -sha256 -nodes -days 365 -subj "/CN=FTP" -newkey rsa:2048 -keyout vsftpd.key -out vsftpd.pem
