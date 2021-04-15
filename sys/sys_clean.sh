sudo polipo -x
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get install bleachbit
sudo rm -rf ~/.cache/thumbnails/*
sudo dpkg --list 'linux-image*'
sudo apt-get remove linux-image-VERSION
sudo du -sh /var/cache/apt
sudo apt-get clean
journalctl --disk-usage
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s
sudo snap set system refresh.retain=2
sudo rm /var/lib/snapd/cache/*
sudo clean_snap.sh
find /var/log -type f -exec /bin/cp /dev/null {} \;
logrotate --force /etc/logrotate.conf
find /var/log/ -name '*[0-5]*' -exec rm {} \;
