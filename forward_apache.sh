#!/usr/bin/env bash

cp -R /vagrant/drupal-6.19/* /var/www/html/

# Copying the default settings
cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php

# if ! [ -L /var/www/html ]; then
#   rm -rf /var/www/html
#   ln -fs /vagrant/www/html /var/www/html
# fi

# Adding the new folder to SELinux context
chcon -R -h -t httpd_sys_content_t /var/www/html

# Set permissions for default site
chmod 777 -R /var/www/html/sites/default

# Same thing but in SELinux context
chcon -R -t httpd_sys_content_rw_t /var/www/html/sites/default

# SELinux is a pain in the ass with symbolic links,
# even worse with symbolic links to shared folders :(...
# setenforce 0

systemctl enable httpd.service
systemctl start httpd.service
systemctl start mysqld