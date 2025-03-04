#!/bin/bash

## This is less of an installer and more of a list of commands to run to get the website started
## Tbh no idea if this is going to work

## Install this if you want
#apt isntall apache2 nodejs

## Setting up the node server
npm init -y
npm install express
npm install cors

cp inv-site.service /etc/systemd/system #move to the folder

## moving the files to the location
#ln -s /root/ansible-setup/inventory-site/ /var/www/ ## yeah i'm using root for this local server fight me (also this does not work lol)
cp inventory-site /var/www
cp inventory-site/inventory-site.conf /etc/apache2/sites-available/

a2dissite * ##turns off all the other sites
a2ensite inventory-site.conf ## starts the site?
systemctl reload apache2 ## restarts the server?

systemctl start inv-site.service
systemctl enable inv-site.service
