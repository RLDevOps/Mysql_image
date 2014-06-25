FROM ubuntu

MAINTAINER Atul Srivastava, atul.srivastava@relevancelab.com

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

# Install MySQL
RUN apt-get install -y mysql-server

# Edit the my.cnf file to allow connections from outside the
# container
RUN sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
ADD jcatalog_ddl.sql /opt/
ADD jcatalog_dml.sql /opt/
RUN chmod 755 /opt/jcatalog_ddl.sql && chmod 755 /opt/jcatalog_dml.sql
ADD start_mysql.sh /usr/bin/
RUN chmod 755 /usr/bin/start_mysql.sh
# Start MySQL Server
RUN service mysql start && mysqladmin -u root password 'root123' && mysql -uroot -proot123 -e "create database catalog;" && mysql -uroot -proot123 -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by 'root123';" && mysql -uroot -proot123 -e "FLUSH PRIVILEGES;" 

# Expose Ports
EXPOSE 3306

# Set Entry point
#ENTRYPOINT ["/usr/bin/mysqld_safe"]
CMD ["/usr/bin/start_mysql.sh"]
