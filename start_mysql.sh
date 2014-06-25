#!/bin/bash
service mysql start
/usr/bin/mysql -uroot -proot123 catalog < /opt/jcatalog_ddl.sql 
/usr/bin/mysql -uroot -proot123 catalog < /opt/jcatalog_dml.sql
tail -f /var/log/mysql.log

