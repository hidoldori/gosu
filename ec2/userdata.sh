#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "<h1>Hello Nginx Demo</h1>" > /var/www/html/index.html
