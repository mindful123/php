#!/bin/bash
# Define variables 
DB_USER=1my1user
DB_PASS=1mypassword
DB_NAME=1mydatabase
URL=1umyrl


# Update packages and install required software apt-get update
sudo apt-get install -y apache2 php mysql-client


#cd /opt

# Download the PHP application code
git clone https://github.com/pbharadwaj1608/crud.git


cd ./crud


# Update the database connection details in the application configuration file 
sed -i "s/DB_USER/$DB_USER/g" index.php
sed -i "s/DB_PASS/$DB_PASS/g" index.php
sed -i "s/DB_NAME/$DB_NAME/g" index.php
sed -i "s/DBServer/$URL/g" index.php

sudo cp index.php /var/www/html


# Create the database tables
wget https://d6opu47qoi4ee.cloudfront.net/employees.sql
#mysql -h $URL -u $DB_USER -p$DB_PASS $DB_NAME < employees.sql


# Update Apache configuration
sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf


# Restart Apache 
sudo systemctl restart apache2
