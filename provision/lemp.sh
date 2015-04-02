#!/usr/bin/env bash

echo "--- Installing PHP-specific packages and Curl ---"
# Install add-apt-repository

echo "--- We want the bleeding edge of PHP, right master? ---"
sudo add-apt-repository -y --force-yes ppa:ondrej/php5
sudo apt-get install -y --force-yes php5-fpm php5-cli
sudo apt-get install -y --force-yes php5-xdebug
sudo apt-get install -y --force-yes php5-sqlite
sudo apt-get install -y --force-yes php5-memcached
sudo apt-get install -y --force-yes php-memcache
sudo apt-get install -y --force-yes php5-gd
sudo apt-get install -y --force-yes php5-mcrypt
sudo apt-get install -y --force-yes php5-mysql
sudo apt-get install -y --force-yes php5-curl

echo "--- Applying modifications to php5-fpm ---"
sed -i '/cgi.fix_pathinfo=1/c cgi.fix_pathinfo=0' /etc/php5/fpm/php.ini
sed -i '/max_execution_time = 30/c max_execution_time = 300' /etc/php5/fpm/php.ini
sed -i '/upload_max_filesize = 2M/c upload_max_filesize = 8M' /etc/php5/fpm/php.ini
sed -i '/listen = 127.0.0.1:9000/c listen = /var/run/php5-fpm.sock' /etc/php5/fpm/pool.d/www.conf

#echo "--- Applying fix for mcrypt ---"
#sudo ln -s /etc/php5/conf.d/mcrypt.ini /etc/php5/mods-available/mcrypt.ini

echo "--- Enabling mcrypt ---"
sudo php5enmod mcrypt

echo "--- Installing & configuring Nginx ---"
echo "--- We want the bleeding edge of NGINX, right master? ---"
sudo add-apt-repository -y ppa:nginx/stable
sudo apt-get update
sudo apt-get install -y --force-yes nginx
# bloody fix for vagrant not syncing properly
sed -i '/sendfile on;/c sendfile off;' /etc/nginx/nginx.conf

echo "--- Configuring default Nginx site to support Vagrant and Laravel ---"
cat << 'EOF' | sudo tee /etc/nginx/sites-available/default
server {
    listen   80; ## listen for ipv4; this line is default and implied
	listen   [::]:80; ## listen for ipv6

    root /vagrant/app/;
    index index.php;

    server_name vagrant.dev;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    if (!-d $request_filename) {
        rewrite ^/(.+)/$ /$1 permanent;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_split_path_info         ^(.+\.php)(.*)$;
    }

    location ~ /\.ht {
        deny all;
    }

    client_max_body_size 8M;
}
EOF

echo "--- Restarting php5-fpm and Nginx ---"
sudo service php5-fpm restart
sudo service nginx restart

echo "--- Fetching and installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
