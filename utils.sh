#parquet head
case $1 in
    head_parquet)
	java -jar parquet-tools-1.6.0.jar head -n5 $1
	;;
    permission)
	find . -type d -exec chmod 755 {} \;	
	find . -type f -exec chmod 644 {} \;
	;;
    fix_resolution)
	rm .config/monitors.xml
	sudo apt-get install --reinstall ubuntu-desktop
	sudo apt-get install --reinstall xorg
	cvt 1024 768 60
	sudo xrandr --newmode "1024x768_60.00"   63.50  1024 1072 1176 1328  768 771 775 798 -hsync +vsync
	sudo xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
	xrandr --addmode eDP-1-1 1024×768_60.00
	sudo xrandr --addmode eDP-1-1 1920x1080_60.00
	xrandr --output eDP-1-1 --mode 1024×768
	;;
	net)
	sudo /etc/init.d/networking restart
	sudo service network-manager restart

	;;
	cast)
#https://askubuntu.com/questions/16584/how-to-connect-and-disconnect-to-a-network-manually-in-terminal
		wpa_passphrase "BLN-Mistral" "BLN-Mistral" > $LAV_DIR/credenza/wifi.conf
                wpa_passphrase "BLN-Fino" "BLN-Fino" > $LAV_DIR/credenza/wifi.conf
		sudo wpa_supplicant -iwlp4s0 -c$LAV_DIR/credenza/wifi.conf -Dwext
                sudo wpa_supplicant -iwlx74da382e422e -c$LAV_DIR/credenza/wifi.conf -Dwext
		nmcli dev wifi
		sudo iw dev wlx74da382e422e connect BLN-Mistral
		nmcli dev wlp4s0 connect BLN-Mistral password BLN-Mistral
		sudo ifconfig wlp4s0 up	
		sudo iwlist wlp4s0 scan
		sudo iwconfig wlp4s0 key s:BLN-Mistral
		sudo iwconfig wlp4s0 mode managed key BLN-Mistral
		sudo iwconfig wlp4s0 essid "BLN-Mistral" key "BLN-Mistral"
		dhclient wlp4s0
		sudo iwlist wlp4s0 scan | grep BLN
		sudo iwlist wlx74da382e422e scan | grep BLN

	;;
    *)
	echo "specify a command"
	exit 1
esac
