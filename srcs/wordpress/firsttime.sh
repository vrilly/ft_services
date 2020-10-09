#!/bin/sh

if [ ! -d "/var/www/wordpress" ]
then
	mkdir -p /var/www/wordpress
	cd /var/www/wordpress
	wp core download
	wp config create \
		--dbname=wordpress \
		--dbuser=wordpress \
		--dbhost=mysql
	wp core install\
		--title="WP running in kubernetes" \
		--admin_user=admin \
		--admin_password="$WP_ADMIN_SECRET" \
		--url="http://192.168.99.122:5050" \
		--admin_email="postmaster@dum.my"
fi

/usr/bin/supervisord
