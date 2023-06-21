lsof -i :80
sudo fuser -k 80/tcp
sudo netstat -pan | grep ":80"
sudo apachectl stop
sudo systemctl restart nginx
sudo pkill -f nginx & wait $!
sudo systemctl start nginx
