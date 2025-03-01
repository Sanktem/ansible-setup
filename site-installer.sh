#!/bin/bash

## This is less of an installer and more of a list of commands to run to get the website started

## Install this if you want
#apt isntall apache2

## moving the files to the location
ln -s /root/ansible-setup/inventory-site/ /var/www/ ## yeah i'm using root for this local server fight me (also this does not work lol)
cp inventory-site/inventory-site.conf /etc/apache2/sites-available/

a2dissite * ##turns off all the other sites
a2ensite inventory-site.conf ## starts the site?
systemctl apache2 reload ## restarts the server?
