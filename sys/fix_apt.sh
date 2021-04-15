sudo apt update --fix-missing
sudo apt install -f
sudo dpkg --configure -a
sudo dpkg -l | grep ^..r
sudo dpkg --remove --force-remove--reinstreq
sudo apt clean
sudo apt update
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
