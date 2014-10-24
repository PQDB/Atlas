#!/bin/bash

# FILE: clip_raster.sh
# DESC: clip raster .tif's using a bounding.shp
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/24

#Place script in folder with desired raster files
#MAKE SURE ALL FILES ARE IN SAME REFERENCE SYSTEM!!
#ie. run the convert scripts first
#input arguments: script, cliptype, mask, input
#The clipped raster files are placed in boxclip or polyclip subdirectories
#NOTE: cant overwrite, will cause error

#ARGUMENTS
#args $1: -b clips to box, -p clips to poly
#args $2: mask.shp
#args $3: input.tif (optional, leave blank to clip all in folder)

MASK=$2

#crop to box
if [ "$1" = "-b" ]; then
	mkdir -p ./boxclip
	#calculate extents
	BASE=`basename $MASK .shp`
	echo "Determining extent of $MASK..."
	EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
				| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
				| sed 's/ - /, /g'`
	EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
	echo "Extents are: $EXTENT"
	#crop all
	if [ "$#" = "2" ]; then
		for INPUT in *.tif 
		do
			echo "clipping $INPUT to box..."
			gdal_translate -projwin $EXTENT -of GTiff $INPUT boxclip/$INPUT
		done
	#crop single
	elif [ "$#" = "3" ]; then
		INPUT=$3
		echo "clipping $INPUT to box..."
		gdal_translate -projwin $EXTENT -of GTiff $INPUT boxclip/$INPUT
	fi
fi

#crop to poly
if [ "$1" = "-p" ]; then
	mkdir -p ./polyclip
	#crop all
	if [ "$#" = "2" ]; then
		for INPUT in *.tif 
		do
			echo "clipping $INPUT to poly..."
			gdalwarp -cutline $MASK -crop_to_cutline $INPUT polyclip/$INPUT
		done
	#crop single
	elif [ "$#" = "3" ]; then
		INPUT=$3
		echo "clipping $INPUT to poly..."
		gdalwarp -cutline $MASK -crop_to_cutline $INPUT polyclip/$INPUT
	fi
fi

echo "clipping complete"