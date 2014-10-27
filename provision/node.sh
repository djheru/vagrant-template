#!/usr/bin/env bash

echo "--- Installing node.js ---"
sudo apt-get update
sudo apt-get install -y  python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y  nodejs
sudo npm install -g express-generator
sudo npm install -g nodemon