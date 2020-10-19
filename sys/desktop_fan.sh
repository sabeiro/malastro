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

##fan controller
sudo apt install libkf5config-dev libkf5auth-dev libkf5package-dev libkf5declarative-dev libkf5coreaddons-dev libkf5dbusaddons-dev libkf5kcmutils-dev libkf5i18n-dev libkf5plasma-dev libqt5core5a libqt5widgets5 libqt5gui5 libqt5qml5 extra-cmake-modules qtbase5-dev libkf5notifications-dev qml-module-org-kde-kirigami2 qml-module-qtquick-dialogs qml-module-qtquick-controls2 qml-module-qtquick-layouts qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel cmake build-essential gettext  

git clone https://github.com/Maldela/fancontrol-gui.git
cd fancontrol-gui
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_KCM=on -DBUILD_PLASMOID=on
make -j
sudo make install


