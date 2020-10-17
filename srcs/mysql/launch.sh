#!/bin/sh

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
	mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
	/usr/bin/mysqld &
	sleep 3
	mysql -e "CREATE DATABASE wordpress;"
	mysql -e "CREATE USER wordpress@'%';"
	mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@'%';"
	mysql -e "GRANT PROCESS on *.* to wordpress@'%';"
	mysql -e "FLUSH PRIVILEGES;"
	sleep 1
	killall mysqld
fi
/usr/bin/mysqld
