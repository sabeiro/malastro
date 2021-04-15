sudo apt install -y vim emacs 
sudo apt install -y gimp inkscape 
sudo apt install -y terminology 

wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
sudo apt install ./slack-desktop-*.deb
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb
# media - codecs
sudo apt-get install ubuntu-restricted-extras mplayer
sudo apt-get install libdvdnav4 libdvdread4 
sudo apt-get install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
sudo apt-get install libaften-dev libmp3lame-dev libx264-dev  libfaad-dev libfaac-dev
# build
sudo apt-get install gcc g++ make cmake pkg-config libpng-dev fakeroot yasm libsqlite3-dev  build-essential 
# battery management
sudo apt install tlp tlp-rdw
sudo tlp start
