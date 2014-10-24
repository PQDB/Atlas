#!/bin/bash

#Place script in desired folder
#Reprojects shapefiles to EPSG:32198
#Append -r option to use bilinear projection (for elevation data)
#The converted raster files are place in the converted subdirectory

mkdir -p ./converted

if [ "$#" = "0" ]; then
	for foo in *.tif
	do
		echo "Reprojecting $foo..."
		gdalwarp -t_srs EPSG:32198 $foo converted/$foo
	done
elif [ "$#" = "1" ] && [ "$1" = "-r" ]; then
	for foo in *.tif
	do
		echo "Reprojecting bilinear $foo..."
		gdalwarp -r bilinear -t_srs EPSG:32198 $foo converted/$foo
	done
else
	echo "error: incorrect input"
fi

echo "Reprojection complete"