#!/bin/bash

#gst-launch-1.0 -e \
#matroskamux name="muxer" ! queue ! filesink location=/tmp/vhs.mkv async=false \
#v4l2src device="/dev/video3" ! tee name=mytee \
#mytee. ! queue ! x264enc ! queue ! muxer. \
#mytee. ! queue ! autovideosink \
#alsasrc device="hw:1" ! queue ! audioconvert ! queue ! vorbisenc ! queue ! muxer.


VIDEO_DEVICE=/dev/video0
AUDIO_DEVICE="hw:0,0"

# Enter the name of the file.
# read -p "Enter file name: " filename
filename=$1

if [ -z "$filename" ]; then
	filename="vhs"
fi


# Enter how many minutes.
#read -p "How many minutes? (If left blank by hitting enter, the default is 62 minutes.): " minutes
if [ -z "$minutes" ]; then
    minutes=62
fi

# Remove any spaces in the file name.
filename=$(echo "$filename" | sed 's/ /-/g')

#read -p "Enter a description: " details

# Create Videos directory if not there.
if ! [ -d $HOME/Videos ]; then mkdir $HOME/Videos; fi

# Encode video. 
#timeout --foreground ${minutes}m cvlc v4l2://$VIDEO_DEVICE :input-slave=alsa://$AUDIO_DEVICE :v4l2-standard=PAL :live-caching=300 --sout '#transcode{vcodec=mp2v,acodec=mpga,ab=128,channels=2,samplerate=48000,fps=29.97,deinterlace}:std{access=file{no-access=file{overwrite}},mux=ts,dst='$HOME/Videos/$filename.ts'}'
#ffmpeg -i $HOME/Videos/$filename.ts -s 720x480 -c:v libx264 -preset medium -crf 22 -acodec copy -metadata comment="$details" -threads 3 $HOME/Videos/$filename.mp4

timeout --foreground ${minutes}m ffmpeg -f v4l2 -standard PAL -thread_queue_size 512 -i $VIDEO_DEVICE -f alsa -thread_queue_size 512 -i $AUDIO_DEVICE -vcodec libx264 -preset superfast -crf 25 -s 720x480 -r 25 -aspect 4:3 -acodec libmp3lame -b:a 128k -channels 2 -ar 48000 $filename.avi



