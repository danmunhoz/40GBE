#!/bin/sh

# Script to set up a new apache server on an Ubuntu machine
# running the tester website

# Should be run as root

# Exit on any errors
set -e

# Create DB
# echo ""
# echo "######Creating DB"
# echo ""
# mysql -u root -p -e 'drop database if exists testador;create database testador;'

# Setup Laravel project
echo ""
echo "######Building website"
echo ""
pkill -f "php artisan queue:listen" || true
rm -rf /var/www/testador
cp -r ./testador /var/www/
cd ../scriptsC/
make
cd -
cp -r ../scriptsC /var/www/testador/resources/rfc
cd /var/www/testador
# composer install
echo ""
echo "#Here you should set specific enviroments variable for this host" > .env
echo ""
cat ./.env.example >> ./.env
# nano .env
chown -R www-data.www-data /var/www/testador
chmod -R 775 /var/www/testador/storage/
mkdir /var/www/testador/app/storage
chmod -R 777 /var/www/testador/app/storage
php artisan key:generate
php artisan migrate
php artisan queue:listen --queue=sfp1 --timeout=0 --tries=1 &
php artisan queue:listen --queue=sfp2 --timeout=0 --tries=1 &
php artisan queue:listen --queue=sfp3 --timeout=0 --tries=1 &
php artisan queue:listen --queue=sfp4 --timeout=0 --tries=1 &
php artisan queue:failed-table
cd -

# Setup apache virtualHost
cp testador.com.conf /etc/apache2/sites-available/
# Enable .htaccess
service apache2 start
a2enmod rewrite
a2ensite testador.com.conf
a2dissite 000-default.conf
service apache2 reload

echo ""
echo "######Success! The website should be available."
echo ""
