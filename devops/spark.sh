sudo su
apt-get update
apt-get install -y locales 
dpkg-reconfigure -f noninteractive locales 
locale-gen C.UTF-8 
/usr/sbin/update-locale LANG=C.UTF-8 
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 
locale-gen 
apt-get clean 
rm -rf /var/lib/apt/lists/*

# Users with other locales should set this in their derivative image
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

apt-get update 
apt-get install -y curl unzip 
apt-get clean 
rm -rf /var/lib/apt/lists/*

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
export PYTHONHASHSEED=0
export PYTHONIOENCODING=UTF-8
export PIP_DISABLE_PIP_VERSION_CHECK=1

# JAVA
export JAVA_HOME=/opt
apt-get update \
apt-get install -y openjdk-8-jre \
apt-get clean \
rm -rf /var/lib/apt/lists/*

# HADOOP
export HADOOP_VERSION=3.0.0
export HADOOP_HOME=/usr/hadoop-$HADOOP_VERSION
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
curl -sL --retry 3  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" | gunzip | tar -x -C /usr/ 
rm -rf $HADOOP_HOME/share/doc \
chown -R root:root $HADOOP_HOME

# SPARK
export SPARK_VERSION=2.4.3
export SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-without-hadoop
export SPARK_HOME=/usr/spark-${SPARK_VERSION}
export SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
export PATH=$PATH:${SPARK_HOME}/bin
curl -sL --retry 3 "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" | gunzip  | tar x -C /usr/ 
mv /usr/$SPARK_PACKAGE $SPARK_HOME \
chown -R root:root $SPARK_HOME \
cp /usr/hadoop-3.0.0/share/hadoop/tools/lib/hadoop-aws-3.0.0.jar $SPARK_HOME/jars/ \
cp /usr/hadoop-3.0.0/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.199.jar $SPARK_HOME/jars/

echo "spark.hadoop.fs.s3a.aws.credentials.provider com.amazonaws.auth.DefaultAWSCredentialsProviderChain" > $SPARK_HOME/conf/spark-defaults.conf

# AWS
# Need an object-based protocol like s3a when running outside of EMR
export S3_PROTOCOL=s3a
export AWS_PROFILE=sandbox-adm

# PYTHON LIBS
pip3 install awscli python-dateutil ptvsd

cd $SPARK_HOME


export HADOOP_HOME=/opt/hadoop
export LIB_PATH=hadoop-tools/hadoop-aws
# Run shell with extra JAR dependencies
$SPARK_HOME/bin/pyspark --packages com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.7.2 #--master spark://ip-172-31-24-101:7077
$SPARK_HOME/bin/pyspark  --jars $HADOOP_HOME/$LIB_PATH/aws-java-sdk-1.7.4.jar,$HADOOP_HOME/$LIB_PATH/hadoop-aws-2.7.2.jar #--master spark://ip-172-31-24-101:7077
