#!/bin/sh

if [ ! -d "/var/www/wordpress" ]
then
	mkdir -p /var/www/wordpress
	cd /var/www/wordpress
	wp core download
	chmod -R 0777 wp-content
	wp config create \
		--dbname=wordpress \
		--dbuser=wordpress \
		--dbhost=mysql
	wp core install\
		--title="WP running in kubernetes" \
		--admin_user=admin \
		--admin_password="$WP_ADMIN_SECRET" \
		--url="http://192.168.99.100:5050" \
		--admin_email="postmaster@dum.my"
	wp user create demo1 demo1@dum.my --role=subscriber --display_name="Demo Subscriber" --user_pass=demo1
	wp user create demo2 demo2@dum.my --role=author --display_name="Demo Author" --user_pass=demo2
	wp user create demo3 demo3@dum.my --role=editor --display_name="Demo Editor" --user_pass=demo3
fi

/usr/bin/supervisord
