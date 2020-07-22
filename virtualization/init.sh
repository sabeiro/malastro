imgName=antani_fat
APP_DIR=app
PORT=5000
# generate requirements file
pip freeze --target > requirements.txt
grep import $(find . -name "*.py") | cut -d ":" -f2 > requirements.txt
awk '$1 ~ /from/ { print $2 }' requirements.txt > tmp.txt
awk '$1 !~ /from/ { print  $2}' requirements.txt >> tmp.txt
cut -d "." -f1 tmp.txt | cut -d "," -f1 | sort | uniq > requirements.txt
rm tmp.txt
#start docker
sudo service docker start
sudo usermod -a -G docker $USER
#create dockerfile
echo "FROM python:3.6
WORKDIR /$APP_DIR
COPY . /
RUN apt-get update
RUN apt -y install vim libspatialindex-dev cmake
#RUN apt -y install apache2 php
RUN pip install -r requirements.txt
ENV LAV_DIR=$APP_DIR
EXPOSE $PORT
CMD [ \"python\", \"src/antani/backend.py\" ]" > Dockerfile
#start/setup container
docker build -t $imgName .
docker run --name $imgName -it -p $PORT:$PORT -v $(pwd):/$APP_DIR $imgName bash
#run prod
docker run --name $imgName -v $(pwd):/app --rm -it -p $PORT:$PORT $imgName
docker exec -it $imgName python src/antani/backend.py
#firewall
sudo yum install httpd nmap -y
sudo yum -y install ufw
sudo amazon-linux-extras install epel
sudo service httpd start
