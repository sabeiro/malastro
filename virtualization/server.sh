#certbot
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y certbot python3-certbot-apache
sudo certbot --apache


