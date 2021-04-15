imgName=intertino
srcDir=$LAV_DIR
LAV_USER=sabeiro
LAV_PROJ=geomadi
case $1 in
    run)
	docker run -it --name c_$imgName \
    	       -p 7474:7474 -p 7687:7687 \
               -p 5432:5432 \
	       -p 27017:27017 -p 27018:27018 -p 27019:27019 -p 28017:28017 \
	       -p 8090:80 -p 2221:22 -p 8888:8888 -p 8889:8889 -p 6006:6006 -p 8000:8000 \
	       -p 5900:5900 \
	       -p 9200:9200 -p 5601:5601 \
	       -v "$srcDir:$srcDir" \
	       $imgName /bin/bash -c "cd $srcDir; su $USER"
	#PYSPARK_DRIVER_PYTHON="jupyter" PYSPARK_DRIVER_PYTHON_OPTS="notebook" SPARK_LOCAL_IP="0.0.0.0" pyspark 
	;;
    notebook)
	docker run -d --name c_$imgName -p 8888:8888 -v $srcDir:$srcDir $imgName sh --net host -c "/usr/local/bin/jupyter notebook --no-browser --ip=0.0.0.0 "
	;;	
    jupyter)
	docker run -it --rm \
	       -p 8888:8888 \
               -v "$srcDir:/home/jovyan/" \
	       jupyter/datascience-notebook \
	       start-notebook.sh #--NotebookApp.base_url=$srcDir
	;;
    kibana)
	docker run --name practical_khorana --link flamboyant_ardinghelli:elasticsearch -p 5601:5601 -d kibana
	;;
    elastic)
	docker run --name flamboyant_ardinghelli -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch
	;;
    nvidia)
	nvidia-docker run -it -v $HOME/docker:/projects -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY nvidia/cuda
	;;
    commit)
        docker commit $(docker ps -a | grep $imgName | awk '{print $1}' ) $imgName
	docker rm c_$imgName
        ;;
    python)
	docker exec -it c_$imgName /usr/bin/python
	;;
    create)
	docker pull $imgName
	;;
    attach)
	docker exec -it $(docker ps | head -n 2 | tail -n 1 | awk '{print $1}' ) /bin/bash
	;;
    exec)
	docker exec -it c_$imgName /bin/bash
	;;
    rm)
	docker rm c_$imgName
	;;
    networkx)
	docker run -it -v $HOME:$HOME --name networkx ubuntu /bin/bash
	apt-get update
	apt-get install -y python3-pip python3-tk python-vtk python3-software-properties
	python3 -m pip install -U pip setuptools
	pip3 install --upgrade pip
	pip3 install numpy scipy matplotlib pandas scikit-learn 
	pip3 install osmnx networkx
	apt-get install -y libspatialindex-dev

	docker commit $(docker ps -a | grep networkx | awk '{print $1}' ) networkx
	export LAV_DIR=$HOME
	docker run -it --rm -v $HOME:$HOME --name networkx networkx "cd $HOME ; python3 routing_zip2zip.py"
	;;
    install)
	#essentials
	apt-get update
	apt-get install -y vim sudo wget curl build-essential less software-properties-common man
	#web-server
	apt-get install -y apache2 php libapache2-mod-php mysql-server nodejs npm
	#vnc
	apt-get install -y x11vnc xvfb firefox
	mkdir ~/.vnc
	x11vnc -storepasswd 1234 ~/.vnc/passwd
	bash -c 'echo "firefox" >> /.bashrc'
	x11vnc -forever -usepw -create
	#user
	useradd $LAV_USER
	usermod -aG sudo $LAV_USER
	echo "$LAV_USER ALL=(ALL:ALL) ALL" >> /etc/sudoers
	chown -R $LAV_USER /home/$LAV_USER
	chsh -s /bin/bash $LAV_USER
	#python
	apt-get install -y python-pip python3-pip python-tk python3-tk python-vtk python3-software-properties
	python -m pip install -U pip setuptools
	pip install --upgrade pip
	pip3 install --upgrade pip
	pip2 install numpy scipy matplotlib pandas scikit-learn keras theano pyspark mayavi jupyter findspark
	pip3 install numpy scipy matplotlib pandas scikit-learn keras theano pyspark mayavi jupyter npm nodejs-legacy findspark jupyterhub notebook
	apt-get install -y python-pandas python3-pandas
	npm install -g configurable-http-proxy
	jupyter notebook --generate-config
	echo -e "#!/bin/bash\nIPYTHON_OPTS=\"notebook --port 8889 --ip='*' --no-browser\"" >> /home/$LAV_USER/.jupyter/jupyter_notebook_config.py
	#java
	add-apt-repository -y ppa:webupd8team/java
	apt-get update
	apt-get install -y default-jdk default-jre scala #oracle-java9-set-default oracle-java9-installer
	sudo update-alternatives --config java
	sudo update-alternatives --config javac
	echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
	sudo apt-get update
	sudo apt-get install sbt
	wget https://dl.bintray.com/sbt/debian/sbt-1.0.2.deb
	dpkg -i sbt-1.0.2.deb
	rm sbt-1.0.2.deb
	#db
	sudo apt-get update
	sudo apt-get install -y postgresql postgresql-contrib postgis
	sudo -u postgres createuser -P $LAV_USER
	sudo -u postgres createdb -O $LAV_USER $LAV_PROJ
	psql -h localhost -U $LAV_USER $LAV_PROJ
	sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" $LAV_PROJ
	ssh -L 127.0.0.1:5433:127.0.0.1:5432 $LAV_USER@127.0.0.1 -N
	#elastic
	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
	echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list
	sudo apt-get update
	sudo apt-get install -y elasticsearch apt-transport-https kibana apache2-utils logstash
	sudo echo -e "network.host: localhost\ncluster.name: $LAV_PROJ\nnode.name: \"$LAV_PROJ\"\npath.data: $LAV_DIR/log/" >> /etc/elasticsearch/elasticsearch.yml
	sudo echo -e "server.host: localhost\nelasticsearch.url: \"http://localhost:9200\"" >> /opt/kibana/config/kibana.yml
	sudo service elasticsearch restart
	sudo update-rc.d kibana defaults 95 10
	sudo service kibana start
	#	cd /etc/ssl/
	#	openssl req -x509 -nodes -newkey rsa:2048 -days 365 -keyout logstash-forwarder.key -out logstash-forwarder.crt -subj /CN=localhost
	#env
	echo -e "export LAV_DIR=/home/sabeiro/lav/motion/\n#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/\nexport PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/bin:/bin:/sbin:/bin/\nexport PYSPARK_DRIVER_PYTHON_OPTS=\"--pylab -c 'from pyspark import SparkContext; sc=SparkContext()' -i\"\nexport SPARK_LOCAL_IP=\"0.0.0.0\"\nexport PYSPARK_DRIVER_PYTHON_OPTS=\nexport LAV_DIR=/home/sabeiro/lav/motion/\nexport SPARK_HOME=\"/usr/local/lib/python3.5/dist-packages/pyspark/\"\nexport PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-VERSION-src.zip:$PYTHONPATH\nexport PYSPARK_DRIVER_PYTHON=ipython\nexport PYSPARK_SUBMIT_ARGS=\"--master local[2] pyspark-shell\"\nexport PYSPARK_PYTHON=/usr/bin/python3\nexport PYSPARK_DRIVER_PYTHON=ipython3\nexport PYSPARK_DRIVER_PYTHON_OPTS=\"notebook --NotebookApp.open_browser=False --NotebookApp.ip='*' --NotebookApp.port=8888\"\n" > /home/$LAV_USER/.profile
	chown -R $LAV_USER /home/$LAV_USER/.profile
	chgrp -R $LAV_USER /home/$LAV_USER/.profile
	#hadoop
	wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.5.2.0/ambari.list
	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
	apt-get update
	apt-get install ambari-server
	#nvidia
	apt-get -s install cuda
	;;
    *)
	echo "specify a command"
	exit 1
esac
