sudo mysql -u root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD';
sudo systemctl stop mysql
sudo mysqld -init-file=~/mysql-pwd
sudo systemctl start mysql
# recover 
use mysql;
update user set authentication_string=password('NEWPASSWORD') where user='root';
flush privileges;
quit
# user
CREATE USER 'kotoba'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON * . * TO 'kotoba'@'localhost';
FLUSH PRIVILEGES;
# import
mysql -u kotoba -p
CREATE DATABASE kotoba;
mysql -u kotoba -p kotoba < kotoba.sql

