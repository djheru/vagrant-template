#!/usr/bin/env bash

echo "--- Installing Apache and PHP ---"
sudo apt-get install -y --force-yes apache2
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y --force-yes php5
sudo apt-get install -y --force-yes libapache2-mod-php5
sudo apt-get install -y --force-yes php5-sqlite php5-memcached
sudo apt-get install -y --force-yes php5-gd php5-mcrypt php5-mysql php5-curl

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y --force-yes php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.idekey="debugit"  
xdebug.remote_host=10.0.2.2  
xdebug.remote_port=10000  
xdebug.remote_enable=1  
xdebug.remote_autostart=0  
xdebug.remote_handler="dbgp"  
EOF

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- Setting document root ---"
sudo rm -rf /var/www/html
sudo ln -fs /vagrant/app /var/www/html

echo "--- Setting dev-level error reporting ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
