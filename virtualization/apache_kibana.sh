## https://logz.io/learn/complete-guide-elk-stack/#installing-elk
## install apache
sudo apt install -y apache2
## install docker
## https://logz.io/blog/elk-stack-on-docker/
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo docker run hello-world
sudo usermod -aG docker $USER
## run containers
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
docker-compose up -d
docker ps

lsof -i 5601
sudo journalctl -u kibana.service
## metricbeat
sudo apt install metricbeat

curl -L -O  https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.1.2-darwin-x86_64.tar.gz
tar xzvf metricbeat-6.1.2-darwin-x86_64.tar.gz


## Elastic logstash kibana
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install elasticsearch
sudo vim /etc/elasticsearch/elasticsearch.yml
sudo service elasticsearch start
sudo apt-get install -y default-jre
sudo apt-get install -y logstash
sudo apt-get install -y kibana
sudo vim /etc/kibana/kibana.yml
sudo service kibana start
sudo apt-get install -y metricbeat
sudo service metricbeat start

sudo cp apache-01.conf /etc/logstash/conf.d/apache-01.conf
sudo service logstash start
