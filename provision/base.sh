!/usr/bin/env bash

echo "--- Updating packages list ---"
sudo apt-get update
sudo apt-get -f install

echo "--- Installing sqlite ---"
sudo apt-get install sqlite3 libsqlite3-dev

echo "--- Installing base packages ---"
sudo apt-get install -y --force-yes vim curl software-properties-common python-software-properties
sudo apt-get install -y --force-yes g++ make build-essential libexpat1-dev libicu-dev

echo "--- Installing git ---"
sudo apt-get install -y --force-yes git
git config --global user.email "djheru@gmail.com" && git config --global user.name "Philip Damra"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing MySQL ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y --force-yes mysql-server-5.6

echo "--- Installing Redis ---"
sudo apt-get install -y --force-yes redis-server

echo "--- Installing Memcached ---"
sudo apt-get install -y --force-yes memcached

echo "-- Installing RabbitMQ --"
echo "deb http://www.rabbitmq.com/debian/ testing main" | sudo tee -a /etc/apt/sources.list.d/rabbitmq.list
curl -L -o ~/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add ~/rabbitmq-signing-key-public.asc
sudo apt-get update && sudo apt-get install -y --force-yes rabbitmq-server erlang-nox

echo "-- Installing SQLite --"
sudo apt-get install -y --force-yes sqlite3 libsqlite3-dev
sudo apt-get -f install