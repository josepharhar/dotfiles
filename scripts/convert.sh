#!/bin/bash
for f in *.heic;do ffmpeg -i "$f" -c:v mjpeg -pix_fmt rgb24 "${f%heic}jpg";done
