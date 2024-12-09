#!/bin/bash

# Update the system
yum update -y

# Install Apache HTTP Server
yum install -y httpd

# Start Apache and enable it to start on boot
systemctl start httpd
systemctl enable httpd

# Install MySQL (Amazon Linux 2 provides MariaDB, which is a compatible fork of MySQL)
yum install -y mariadb-server

# Start MySQL and enable it to start on boot
systemctl start mariadb
systemctl enable mariadb

# Secure MySQL installation
mysql_secure_installation <<EOF

y
password
password
y
y
y
y
EOF

# Install PHP and required modules
yum install -y php php-mysqlnd

# Install phpMyAdmin
yum install -y epel-release
yum install -y phpmyadmin

# Start phpMyAdmin and Apache
systemctl restart httpd

# Allow HTTP service through firewall (if necessary)
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
