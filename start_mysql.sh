#!/bin/bash
service mysqld start
/usr/bin/mysql -uroot -proot123 catalog < /opt/Catalog_DBscripts/jacatlog_ddl.sql 
/usr/bin/mysql -uroot -proot123 catalog < /opt/Catalog_DBscripts/jacatlog_dml.sql
/usr/bin/mysqld_safe
