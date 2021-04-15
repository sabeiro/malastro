
openssl req -x509 -newkey rsa:2048 -keyout keytmp.pem -out cert.pem -days 365
openssl rsa -in keytmp.pem -out key.pem

openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 1024 -in server.csr -signkey server.key -out server.crt

openssl s_client -showcerts -connect ${HOSTNAME}:443


sudo addgroup nodecert
sudo adduser $USER nodecert
sudo adduser root nodecert
sudo chgrp -R nodecert /etc/letsencrypt/live
sudo chgrp -R nodecert /etc/letsencrypt/archive
sudo chmod 710 /etc/letsencrypt/live
sudo chmod 710 /etc/letsencrypt/archive

