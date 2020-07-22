fName=$1
#fName="shaky.mp4"
#transcode  -J stabilize --mplayer_probe -i "input.MTS"
#ffmpeg -i "input.MTS" -vf deshake out.avi
## show movement on top of video
#ffmpeg -i $fName -vf vidstabdetect=shakiness=5:show=1 movement_$fName
#ffmpeg -i $fName -vf vidstabtransform=zoom=5:input="transforms.trf" stable_$fName
#ffmpeg -i $fName -vf vidstabdetect=show=1 stable_$fName

## create transform.trf
rm transforms.trf
mv $fName unstable_$fName
ffmpeg -y -i unstable_$fName -vf vidstabdetect -f null -
ffmpeg -y -i unstable_$fName -vf vidstabtransform,unsharp=5:5:0.8:3:3:0.4 $fName
## zooming
# rm transforms.trf
# ffmpeg -y -i stable_$fName -vf vidstabdetect -f null -
# ffmpeg -y -i stable_$fName -vf vidstabtransform=zoom=5:input="transforms.trf"  stable2_$fName
## smoothing
# rm transforms.trf
# ffmpeg -y -i stable2_$fName -vf vidstabdetect -f null -
# ffmpeg -y -i stable2_$fName -vf vidstabtransform=smoothing=30:input="transforms.trf"  stable3_$fName
