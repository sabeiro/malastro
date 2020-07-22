sudo apt install -y apache2
sudo apt install -y mysql-server
sudo apt install -y php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php
sudo apt-get install -y php7.2-xmlrpc
sudo service apache2 restart
php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'


sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.4
sudo apt-get install -y libapache2-mod-php php-mcrypt php-mysql
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.4-fpm
sudo service apache2 reload
