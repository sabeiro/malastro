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


