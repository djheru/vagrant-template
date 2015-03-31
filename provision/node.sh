#!/usr/bin/env bash

echo "--- Installing node.js via nvm ---"
sudo apt-get update
sudo su vagrant -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"
source /home/vagrant/.nvm/nvm.sh
source /home/vagrant/.bashrc
nvm install 0.10
nvm alias default 0.10
nvm use default

echo "-- Installing some useful global packages --"
npm install -g express-generator
npm install -g nodemon
npm install -g gulp
npm install -g karma
npm install -g yo
npm install -g mocha
npm install -g bower
