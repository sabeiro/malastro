sudo mysql -u root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD';
sudo /etc/init.d/mysql stop
sudo mkdir /var/run/mysqld
sudo chown mysql /var/run/mysqld
sudo mysqld_safe --skip-grant-tables&
sudo mysql --user=root mysql
UPDATE mysql.user SET authentication_string=null WHERE User='root';
flush privileges;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '';
update user set authentication_string=PASSWORD('') where user='root';
sudo killall -u mysql
sudo /etc/init.d/mysql start
sudo mysql -p -u root

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
ALTER USER 'kotoba'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON * . * TO 'kotoba'@'localhost';
FLUSH PRIVILEGES;
# import
mysql -u kotoba -p
CREATE DATABASE kotoba;
mysql -u kotoba -p kotoba < kotoba.sql

sudo ufw allow mysql
sudo ufw restart
sudo vim /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb
# external access
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
# change: bind-address = 0.0.0.0
sudo systemctl restart mysql
sudo netstat -tulnp | grep mysqld
sudo ufw allow 3306/tcp
mysql -u root -p
RENAME USER 'kotoba'@'localhost' TO 'kotoba'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kotoba'@'%';
FLUSH PRIVILEGES;


