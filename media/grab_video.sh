# record stream
ffmpeg -f v4l2 -standard PAL -thread_queue_size 512 -i /dev/video0 -f alsa -thread_queue_size 512 -i hw:2,0 -vcodec libx264 -preset superfast -crf 25 -s 720x576 -r 25 -aspect 4:3 -acodec libmp3lame -b:a 128k -channels 2 -ar 48000 out.avi


ffmpeg -f video4linux2 -f rawvideo -pix_fmt yuyv422 -i /dev/video0 out.mpg

#ffmpeg -f alsa -ac 2 -i hw:1,0 -f x11grab -r 15 -s 1920x1200 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.avi

ffmpeg -f alsa -ac 2 -i hw:1,0 -f x11grab -r 15  -i :0.0 -acodec pcm_s16le -vcodec libx264  -threads 0 output.avi

