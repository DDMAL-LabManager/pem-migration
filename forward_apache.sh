#!/usr/bin/env bash

# cp -R /vagrant/drupal-6.19/* /var/www/html/

if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/www/html /var/www/html
fi

# # Copying the default settings
/bin/cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php

# # Set permissions for default site
chmod 777 -R /var/www/html/sites/default

# Due to issues with NFS and vboxsf filesystems, the SELinux
# security context cannot be changed in the symbolic links :(...
# Therefore, SELinux is off
setenforce 0

# If one day that changes... This wil do it...
# chcon -R -h -t httpd_sys_content_t /var/www/html
# chcon -R -t httpd_sys_content_rw_t /var/www/html/sites/default

service httpd start

service mysqld start

# SECURE_MYSQL=$(expect -c "
# set timeout 10
# spawn mysql_secure_installation
# expect \"Enter current password for root (enter for none):\"
# send \"\r\"
# expect \"Change the root password?\"
# send \"n\r\"
# expect \"Remove anonymous users?\"
# send \"y\r\"
# expect \"Disallow root login remotely?\"
# send \"y\r\"
# expect \"Remove test database and access to it?\"
# send \"y\r\"
# expect \"Reload privilege tables now?\"
# send \"y\r\"
# expect eof
# ")

# echo "$SECURE_MYSQL"

