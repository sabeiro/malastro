sudo usermod -a -G dialout $USER
sudo chmod a+rw /dev/ttyACM0 


sudoedit /etc/udev/rules.d/50-myusb.rules
KERNEL=="ttyUSB[0-9]*",MODE="0666"
KERNEL=="ttyACM[0-9]*",MODE="0666"
KERNEL=="ttyUSB[0-9]*",NAME="tts/USB%n",SYMLINK+="%k",GROUP="uucp",MODE="0666"

ACTION=="add", KERNEL=="ttyACM[0-9]*", ATTRS{2341}=="ffff", ATTRS{8037}=="0005", MODE="0666"

sudo apt install avrdude
sudo usermod -a -G dialout $USER
sudo chmod a+rw /dev/ttyACM0
sudo udevadm trigger
sudo usermod -a -G tty $USER
ls -l /dev/ttyACM*

