openssl genrsa -des3 -out local_rootCA.key 2048
openssl req -x509 -new -nodes -key local_rootCA.key -sha256 -days 1024 -out local_rootCA.pem
sudo cp local_rootCA.pem /etc/ssl/certs/
sudo update-ca-certificates 
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config ./server.csr.cnf
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 800 -sha256 -extfile v3.ext

## mkcert solution
sudo apt install mkcert libnss3-tools
mkcert -install
mkcert localhost

