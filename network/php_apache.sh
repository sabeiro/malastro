sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.4 php7.4-cli
sudo apt-get install -y libapache2-mod-php php-mcrypt php-mysql
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.4-fpm
sudo service apache2 reload
