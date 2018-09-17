#!/bin/bash

set -euo pipefail

filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

echo $1

if [ $(mimetype -b "$1") == "image/svg+xml" ]
then
  echo "this is a svg"
  java -Xmx15g  -jar ~/batik-1.8/batik-rasterizer-1.8.jar -w 8000 -bg "255.255.255.255" -m image/tiff $1 -d "${filename}.tif" 

#  rsvg-convert -d 3000 -p 3000 -a -f png -o ${filename}.png $1
  tgtExtension="tif"
  #gm convert ${filename}.png -profile sRGB_v4_ICC_preference.icc ${filename}.jpg    
  #rm ${filename.png}
else
	gm convert $1 -profile sRGB_v4_ICC_preference.icc ${filename}.jpg  
	tgtExtension="jpg"
fi




rm -f ${filename}.dzi
rm -rf ${filename}_files
./magick-slicer.sh ${filename}.$tgtExtension ${filename}
