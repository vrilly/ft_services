#!/bin/sh

apk add nginx php7-fpm php7-phar php7-json curl php7-curl \
	php7-openssl php7-pdo_mysql php7-mysqli php7-iconv \
	php7-gd php7-zip php7-imagick php7-mbstring php7-fileinfo \
	php7-exif php7-dom mysql-client supervisor
rm /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx
curl -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/bin/wp
