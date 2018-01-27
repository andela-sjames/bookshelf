#!/usr/bin/env bash

# reference: https://gist.github.com/davisford/8000332

echo "-------------------- updating package lists and installing packages"
apt-get update && apt-get -y install python-pip python-dev build-essential curl
apt-get install -y libpq-dev postgresql postgresql-contrib libmysqlclient-dev

echo "-------------------- installing virtualenv"
curl -O https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.10.1.tar.gz
tar xvfz virtualenv-1.10.1.tar.gz
cd virtualenv-1.10.1
sudo python setup.py install

# fix permissions
echo "-------------------- fixing listen_addresses on postgresql.conf"
sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/9.1/main/postgresql.conf

echo "-------------------- fixing postgres pg_hba.conf file"
# replace the ipv4 host line with the above line
cat >> /etc/postgresql/9.1/main/pg_hba.conf <<EOF
# Accept all IPv4 connections - FOR DEVELOPMENT ONLY!!!
host    all         all         0.0.0.0/0             md5
EOF

echo "-------------------- creating postgres vagrant role with password vagrant"
# Create Role and login
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

echo "-------------------- creating wtm database"
# Create WTM database
sudo su postgres -c "createdb -E UTF8 -T template0 --locale=en_US.utf8 -O vagrant wtm"

echo "-------------------- creating bookshelf database"
# not really used for this tutorial but here for those who might need it though... 
sudo su postgres -c "psql -c \"CREATE DATABASE bookshelf\" " 
sudo su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE bookshelf to vagrant\" "

echo "-------------------- creating vagrant database"
sudo su postgres -c "psql -c \"CREATE DATABASE vagrant\" " 
sudo su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE vagrant to vagrant\" "

echo "....... Making use of sqlite for this demo... ¯\_(ツ)_/¯ to make use of postgres..."
echo "....... uncomment the config in settings.py you can either vagrant reload, vagrant destroy and/or Vagrant up"
echo "....... reference the docs for use case :) "
