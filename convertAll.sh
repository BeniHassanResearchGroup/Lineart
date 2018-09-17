#!/bin/bash

set -euo pipefail

for file in *.svg; 
	do ./runMagick.sh $file; 
done
	

for file in *.tif; 
	do ./runMagick.sh $file; 
done

for file in *.dzi;
	do
	filename=$(basename $file ".dzi")
	echo ${filename}.html
	sed 's/{1}/$file/g' template.html > ${filename}.html
	done

