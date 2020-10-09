#!/bin/sh

apk add nginx php7-fpm php7-phar php7-json curl php7-curl php7-openssl php7-pdo_mysql php7-mysqli php7-iconv mysql-client supervisor
rm /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx
curl -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/bin/wp
