#!/usr/bin/env bash

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl software-properties-common python-software-properties
sudo apt-get install -y g++ make build-essential libexpat1-dev libicu-dev git

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing MySQL ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server-5.5

echo "--- Installing Redis ---"
sudo apt-get install -y redis-server

echo "--- Installing Mongodb ---"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null
sudo sh -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | sudo tee /etc/apt/sources.list.d/mongodb.list' > /dev/null
sudo apt-get update
sudo apt-get install -y mongodb-org

echo "--- Installing Postgres ---"
sudo apt-get install postgresql-9.3