FROM ubuntu

MAINTAINER Atul Srivastava, atul.srivastava@relevancelab.com

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

# Install MySQL
RUN apt-get install -y mysql-server

# Edit the my.cnf file to allow connections from outside the
# container
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Start MySQL Server
RUN service mysql start && /usr/bin/mysqladmin -u root password root123 && /usr/bin/mysql -uroot -proot123 -e "delete from mysql.user where User!='root';" && /usr/bin/mysql -uroot -proot123 -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by 'root123';" && /usr/bin/mysql -uroot -proot123 -e "FLUSH PRIVILEGES;"

# Expose Ports
EXPOSE 3306

# Set Entry point
CMD ["/usr/bin/mysqld_safe"]