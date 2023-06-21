#sudo usermod -a -G www-data sabeiro
#sudo adduser sabeiro www-data
WWW_DIR="/var/www/html"
sudo chown -R sabeiro:www-data $WWW_DIR
sudo chmod 644 $(find $WWW_DIR -type f)
sudo chmod 755 $(find $WWW_DIR -type d)
#sudo find $WWW_DIR -type f -exec chmod 644 {} \;
#sudo find $WWW_DIR -type d -exec chmod 755 {} \;


