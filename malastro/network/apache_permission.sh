sudo groupadd www-data
sudo usermod -a -G www-data apache
sudo usermod -a -G www-data $USER
sudo chown -R $USER:www-data /var/www/html
find /var/www/html -type d -exec chmod 2775 {} \;
find /var/www/html -type f -exec chmod 0664 {} \;
