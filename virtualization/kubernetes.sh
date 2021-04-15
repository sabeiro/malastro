imgName=intertino
srcDir=$LAV_DIR
LAV_USER=sabeiro
LAV_PROJ=geomadi
case $1 in
    install)
	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
	sudo apt install kubeadm
	kubectl cluster-info
	kubeadm version
	sudo hostnamectl set-hostname master-node
	sudo echo '127.0.0.1       master-node' > /etc/hosts
	hostnamectl set-hostname slave-node
	sudo kubeadm init --pod-network-cidr=10.244.0.0/16
	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
	
	;;
    *)
	echo "specify a command"
	exit 1
esac
