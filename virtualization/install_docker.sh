sudo apt-get install docker docker-engine docker.io containerd runc
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl restart docker
