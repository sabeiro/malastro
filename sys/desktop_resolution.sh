        rm .config/monitors.xml
        sudo apt-get install --reinstall ubuntu-desktop
        sudo apt-get install --reinstall xorg
        cvt 1024 768 60
        sudo xrandr --newmode "1024x768_60.00"   63.50  1024 1072 1176 1328  768 771 775 798 -hsync +vsync
        sudo xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
        xrandr --addmode eDP-1-1 1024×768_60.00
        sudo xrandr --addmode eDP-1-1 1920x1080_60.00
        xrandr --output eDP-1-1 --mode 1024×768


