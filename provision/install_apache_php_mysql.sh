#!/bin/bash
# Update and install necessary packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y apache2 php php-mysql mysql-client

# Install PHPMyAdmin
sudo apt-get install -y phpmyadmin

# Start Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

# MySQL installation and configuration (for MySQL server)
# Assuming MySQL server is on another instance, you can configure connections here
