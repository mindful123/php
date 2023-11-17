#!/bin/bash
echo "vmuserdata" > /tmp/log
 echo `date`  >> /tmp/log
 
# Define variables 
DB_USER=my1user
DB_PASS=mypassword1@
DB_NAME=mydatabase
URL="myflexiblemysqlserver74842.mysql.database.azure.com"


# Update packages and install required software
sudo apt-get update    >> /tmp/log
sudo apt-get install -y apache2 php mysql-client    >> /tmp/log


cd /opt

# Download the PHP application code
#git clone https://github.com/pbharadwaj1608/crud.git
#cd ./crud

git clone https://github.com/mindful123/php.git   >> /tmp/log
cd ./php

# Update the database connection details in the application configuration file 
sed -i "s/DB_USER/$DB_USER/g" index.php
sed -i "s/DB_PASS/$DB_PASS/g" index.php
sed -i "s/DB_NAME/$DB_NAME/g" index.php
sed -i "s/DBServer/$URL/g" index.php

sed -i "s/Viewer/VMSSphpApp_Viewer/g" index.php
sudo cp index.php /var/www/html


# Create the database tables
wget https://d6opu47qoi4ee.cloudfront.net/employees.sql
mysql -h $URL -u $DB_USER -p$DB_PASS $DB_NAME < employees.sql


# Update Apache configuration
sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf


# Restart Apache 
sudo systemctl restart apache2
