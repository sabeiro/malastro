gst-launch-1.0 ximagesrc startx=1280 use-damage=0 ! video/x-raw,framerate=30/1 ! videoscale method=0 ! video/x-raw,width=640,height=480  ! ximagesink
