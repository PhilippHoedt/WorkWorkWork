#!/usr/bin/env bash
BASE_PATH=/var/www/project

apt-get update

# setup virtualhost
cat > /home/vagrant/.vimrc <<- CONFIG
sy on
set hlsearch
colorscheme evening
CONFIG

#ll aktivieren
sed -i s/#alias\ ll\=\'ls\ \-l\'/alias\ ll=\'ls\ -lah\'/g /home/vagrant/.bashrc

# cd to project directory
sed -i '$acd\ /var/www/project' /home/vagrant/.bashrc

sed -i '$aexport\ SYMFONY_ENV=dev' /home/vagrant/.bashrc

# Virtual host config
rm /etc/apache2/sites-enabled/000-default.conf -f
rm /etc/apache2/sites-enabled/vhosts.conf -f
rm /etc/apache2/sites-enabled/000-dev.work-work-work.de.conf -f

touch /etc/apache2/sites-available/dev.work-work-work.de.conf
cat > /etc/apache2/sites-available/dev.work-work-work.de.conf <<- CONFIG
DirectoryIndex index.php index.html

<VirtualHost *:80>
  ServerName localhost
  ServerAlias dev.work-work-work.de.de
  DocumentRoot /var/www/project/web

  <Directory "/var/www/project/web">
    AllowOverride All
    Options -Indexes +FollowSymLinks
    Require all granted
  </Directory>
</VirtualHost>
CONFIG

ln -s /etc/apache2/sites-available/dev.work-work-work.de.conf /etc/apache2/sites-enabled/000-dev.work-work-work.de.conf

service apache2 restart