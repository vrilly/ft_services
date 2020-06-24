#!/bin/sh

apk add mariadb
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
mkdir -p /run/mysqld
