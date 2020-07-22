## uninstall
sudo apt-get purge nvidia*
sudo apt -y autoremove
sudo apt-get -y remove --purge '^nvidia-.*'
sudo apt-get install ubuntu-desktop
echo 'nouveau' | sudo tee -a /etc/modules
sudo rm /etc/X11/xorg.conf
sudo mokutil --disable-validation ## disable secure boot
sudo nvidia-uninstall
#list cards
sudo lspci
lshw -numeric -C display
lspci -vnn | grep VGA
ubuntu-drivers devices
lsmod | grep nvidia

sudo apt autoremove xserver-xorg-video-nouveau
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo update-initramfs -u
sudo reboot
#install
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-340 nvidia-setting

#cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda



sudo apt-get install build-essential dkms
sudo apt-get install freeglut3 freeglut3-dev libxi-dev libxmu-dev

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda


sudo dpkg --add-architecture i386
sudo apt update
sudo apt install build-essential libc6:i386

sudo add-apt-repository ppa:graphics-drivers
sudo apt search nvidia
sudo apt install xserver-xorg-video-nvidia-440 nvidia-utils-440 nvidia-kernel-source-440 nvidia-driver-440 nvidia-dkms-440
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-driver-440
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo ubuntu-drivers autoinstall

sudo nvidia-bug-report.sh
sudo journalctl -b0 _COMM=gdm-x-session --no-pager >journal.txt



