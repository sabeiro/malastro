sudo a2enmod ssl
sudo a2enmod proxy
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo a2enmod proxy_connect
sudo a2enmod proxy_html
sudo a2enmod fastcgi
sudo a2enmod proxy_ajp
sudo a2enmod rewrite
sudo a2enmod deflate
sudo a2enmod headers


#ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/proxy_http.load
sudo apache2ctl configtest
sudo apache2ctl graceful

sudo echo 'ServerName localhost' >> /etc/apache2/conf.d/fqdn
sudo echo 'ServerName localhost' >> /etc/apache2/conf-available/servername.conf
