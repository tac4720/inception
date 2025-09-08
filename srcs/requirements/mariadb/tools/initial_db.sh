#!/bin/sh

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "[mysqld]" > /etc/mysql/mariadb.conf.d/99-bind.cnf
    echo "bind-address=0.0.0.0" >> /etc/mysql/mariadb.conf.d/99-bind.cnf

    
    chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

exec mysqld_safe --user=mysql --datadir=/var/lib/mysql
