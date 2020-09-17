#!/bin/bash

cd /var/www/vhosts/localhost/html

echo "<IfModule mod_rewrite.c>" >> .htaccess
echo "  RewriteEngine On" >> .htaccess
echo "  RewriteCond %{HTTP_HOST} ^$OLD_DOMAIN$ [OR]" >> .htaccess
echo "  RewriteCond %{HTTP_HOST} ^www.$OLD_DOMAIN$" >> .htaccess
echo "  RewriteRule (.*)$ http://$NEW_DOMAIN/$1 [R=301,L]" >> .htaccess
echo "</IfModule>" >> .htaccess

chown -R lsadm:lsadm .*

chmod -R g+rw .*

chown -R lsadm:lsadm *

chmod -R g+rw *

/usr/local/lsws/bin/lswsctrl restart

echo "Redirect | Install Completed"
