#!/bin/sh

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
	mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
fi
/usr/bin/mysqld
