#!/usr/bin/env bash

echo "--- Installing Python stuff ---"
curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python -
sudo apt-get --yes --force-yes install python-pip
sudo apt-get --yes --force-yes install python-virtualenv
