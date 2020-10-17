#!/bin/sh

apk add nginx php7-fpm php7-phar php7-json curl php7-curl \
	php7-openssl php7-pdo_mysql php7-mysqli php7-iconv \
	php7-gd php7-zip php7-imagick php7-mbstring php7-fileinfo \
	php7-exif php7-dom php7-session mysql-client supervisor wget
rm /etc/nginx/conf.d/default.conf
mkdir -p /run/nginx
cd /var/www
mkdir phpmyadmin
wget "https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz" -O wp.tgz
cd phpmyadmin
tar xzf ../wp.tgz --strip 1
rm ../wp.tgz
