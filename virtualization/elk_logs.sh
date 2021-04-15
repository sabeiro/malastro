#https://logz.io/blog/apache-log-analyzer/
#https://logz.io/blog/elk-stack-on-docker/
#https://logz.io/blog/docker-logging/

git clone https://github.com/deviantony/docker-elk.git
cd /docker-elk
docker-compose up -d

docker pull docker.elastic.co/beats/metricbeat:7.6.2
curl -L -O https://raw.githubusercontent.com/elastic/beats/7.6/deploy/docker/metricbeat.docker.yml

docker run -d \
  --name=metricbeat \
  --user=root \
  --volume="$(pwd)/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --volume="/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro" \
  --volume="/proc:/hostfs/proc:ro" \
  --volume="/:/hostfs:ro" \
  docker.elastic.co/beats/metricbeat:7.6.2 metricbeat -e \
  -E output.elasticsearch.hosts=["localhost:9200"]


wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https ca-certificates -y
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main"| sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update
sudo apt-cache policy metricbeat
sudo apt-get install metricbeat
sudo vim /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo tail -f /var/log/metricbeat/metricbeat

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb
sudo dpkg -i filebeat-7.6.2-amd64.deb


curl -u elastic:changeme -XPUT 'http://localhost:9200/_template/metricbeat' -H 'Content-Type: application/json' -d@/etc/metricbeat/metricbeat.template-es2x.json

curl -u elastic:changeme -XGET 'http://localhost:9200/metricbeat-*/_search?pretty=true&q=*:*&size=2'
curl -u elastic:changeme -XGET 'http://localhost:9200/metricbeat-*/_count'

curl -u elastic:changeme http://localhost:9200
curl -u elastic:changeme -XGET 'http://localhost:9200/_template/metricbeat' | python -m json.tool | more

