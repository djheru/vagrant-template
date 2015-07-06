#!/usr/bin/env bash

echo "--- Installing node.js via nvm ---"
sudo apt-get update
sudo su vagrant -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"
source /home/vagrant/.nvm/nvm.sh
source /home/vagrant/.bashrc
nvm install 0.11
nvm alias default 0.11
nvm use default

echo "-- Installing some useful global packages --"
npm install -g express-generator
npm install -g nodemon
npm install -g gulp
npm install -g karma
npm install -g yo
npm install -g bower
npm install -g jasmine
npm install -g generator-karma
npm install -g generator-angular
npm install -g generator-angular-fullstack
npm install -g phantomjs
npm install -g pm2
npm install -g strongloop

