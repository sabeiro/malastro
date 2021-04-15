wget https://downloads.apache.org/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
tar xvf spark-*
sudo mv spark-* /opt/spark
echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile
source ~/.profile
start-master.sh
start-slave.sh spark://localhost:8081
pyspark

stop-master.sh
stop-slave.sh
