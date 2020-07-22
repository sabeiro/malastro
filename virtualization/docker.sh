imgName=intertino
srcDir=$LAV_DIR
LAV_USER=sabeiro
LAV_PROJ=geomadi
case $1 in
    run)
	docker run -it --name c_$imgName /bin/bash
	;;
    stop_all)
	docker stop $(docker ps -a -q)
	;;
    rm_all)
	docker rm $(docker ps -a -q)
	;;
    rm_image)
	docker rmi $(docker images -q)
	;;
    notebook)
	docker run -d --name c_$imgName -p 8888:8888 -v $srcDir:$srcDir $imgName sh --net host -c "/usr/local/bin/jupyter notebook --no-browser --ip=0.0.0.0 "
	;;	
    jupyter)
	docker pull jupyter/datascience-notebook
	;;
    nvidia)
	docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
	nvidia-docker run -it -v $HOME/docker:/projects -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY nvidia/cuda
	;;
    odoo)
	#https://hub.docker.com/_/odoo/
	docker pull odoo
	docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:10
	docker run -p 8069:8069 --name odoo --link db:db -t odoo
	docker stop odoo
	docker start -a odoo
	docker run -v /path/to/config:/etc/odoo -p 8069:8069 --name odoo --link db:db -t odoo
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
    install)
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	;;
    *)
	echo "specify a command"
	exit 1
esac
