#!/bin/bash
secs=$(date --date "2021-12-29" +%s)
let secs-=$(date +%s)
msecs=$(( $secs * 1000 )) 
echo $msecs
