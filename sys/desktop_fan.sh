sudo apt remove tracker tracker-extract tracker-miner-fs


systemctl --user mask tracker-store.service tracker-miner-fs.service tracker-miner-rss.service tracker-extract.service tracker-miner-apps.service tracker-writeback.service
tracker reset --hard


sudo apt-get install lm-sensors xsensors fancontrol 
sudo sensors-detect
sudo service kmod start
sudo pwmconfig
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_enforce_resources=lax"
sudo update-grub
sudo reboot
sudo service module-init-tools restart

find /sys/devices -type f -name "temp*_input"
sudo vim /etc/thinkfan.conf


sudo apt-get install i8kutils
sudo cat 'i8k' >> /etc/modules
sudo cat 'options i8k force=1' > /etc/modprobe.d/i8k.conf
sudo modprobe i8k force=1

sudo vim /etc/i8kmon.conf

i8kmon

sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get install tlp tlp-rdw
sudo tlp start
sudo tlp-stat
