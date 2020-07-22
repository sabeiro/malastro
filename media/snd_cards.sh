sudo apt-get install qv4l2 v4l-utils ffmpeg
sudo apt-get install gstreamer1.0-tools gstreamer1.0-alsa gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

cat /proc/asound/cards
alsamixer #F6
arecord -l

v4l2-ctl --list-devices 
pactl list | grep -C 50 'Description: USBTV007'

VIDEO_DEVICE=/dev/video0
AUDIO_DEVICE="hw:1"
VIDEO_CAPABILITIES="autovideosink"
AUDIO_CAPABILITIES="pulsesink"

gst-launch-1.0 v4l2src device=/dev/video0 ! autovideosink # test video
gst-launch-1.0 alsasrc device="hw:1" ! pulsesink # test audio

gst-launch-1.0 v4l2src device=$VIDEO_DEVICE ! autovideosink ! filesink location=test-$( date --iso-8601=seconds ).avi

gst-launch-1.0 alsasrc device=$AUDIO_DEVICE ! pulsesink ! filesink location=test-$( date --iso-8601=seconds ).avi


gst-launch ximagesrc ! ffmpegcolorspace ! queue \
! vp8enc quality=10 speed=2 ! mux. alsasrc ! audio/x-raw-int ! queue \
! audioconvert ! vorbisenc ! mux. webmmux name=mux \
! filesink location=screencast.webm

vconv -f x11grab -r 30 -s 1280x1024 -i :0.1 -c:v mpeg4 -b:v 1000k \
-vf "hflip" -vf "scale=640:480" -sws_flags "neighbor" -f avi - | avplay -i -



gst-launch-1.0 \
    v4l2src device=$VIDEO_DEVICE \
        ! $VIDEO_CAPABILITIES \
        ! avimux \
        ! filesink location=test-$( date --iso-8601=seconds ).avi




gst-launch-1.0 \
    v4l2src device=$VIDEO_DEVICE \
        ! $VIDEO_CAPABILITIES \
        ! mux. \
    alsasrc device=$AUDIO_DEVICE \
        ! $AUDIO_CAPABILITIES \
        ! mux. \
    avimux name=mux \
        ! filesink location=test-$( date --iso-8601=seconds ).avi
        
        

gst-launch-1.0 \
    v4l2src device=$VIDEO_DEVICE \
        ! $VIDEO_CAPABILITIES \
        ! videoconvert \
        ! theoraenc \
        ! queue \
        ! mux. \
    alsasrc device=$AUDIO_DEVICE \
        ! $AUDIO_CAPABILITIES \
        ! audioconvert \
        ! vorbisenc \
        ! mux. \
    oggmux name=mux \
        ! filesink location=test-$( date --iso-8601=seconds ).ogg

gst-launch-1.0 -e matroskamux name="muxer" ! queue ! filesink location=/tmp/vhs.mkv v4l2src ! queue ! x264enc ! queue ! muxer. alsasrc device="hw:1" ! queue ! audioconvert ! queue ! vorbisenc ! queue ! muxer. # grab

gst-launch-1.0 -e matroskamux name="muxer" ! queue ! filesink location=/tmp/vhs.mkv async=false v4l2src ! tee name=mytee mytee. ! queue ! x264enc ! queue ! muxer. mytee. ! queue ! autovideosink alsasrc device="hw:1" ! queue ! audioconvert ! queue ! vorbisenc ! queue ! muxer. #grab

ffmpeg -i vhs.mkv -vb 700k -ab 100k seekable-vhs.mkv # re encode


# vlc
vlc v4l2:///dev/video3:audio-method=2:adev=hw.1,0 --v4l2-vdev /dev/video3
