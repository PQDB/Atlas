#!/bin/bash
# Jordan Quan, Oct1, 2014
#Clips shapefiles using a bounding.shp

#Place script in folder with desired shapefiles
#MAKE SURE ALL FILES ARE IN SAME REFERENCE SYSTEM!!
#IE. RUN CONVERT_SHAPEFILES.SH FIRST
#input arguments: script, cliptype, mask, input
#The clipped shapefiles are placed in boxclip and polyclip subdirectories
#NOTE: cant overwrite, will cause error

#ARGUMENTS
#args $1: -b clips to box, -p clips to poly (takes much longer)
#args $2: mask.shp
#args $3: input.shp (optional, leave blank to clip all in folder

#making output folders
mkdir -p ./boxclip
mkdir -p ./polyclip

#calculate clipping mask
MASK=$2
BASE=`basename $MASK .shp`
echo "Determining extent of $MASK..."
EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
			| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
			| sed 's/ - /, /g'`
EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
echo "Extents are: $EXTENT"

#clip all files
if [ "$#" = "2" ];then
	for INPUT in *.shp
	do
		echo "clipping $INPUT to box..."
		ogr2ogr -f "ESRI Shapefile" -clipsrc $EXTENT boxclip/$INPUT $INPUT
		echo "boxclip complete"
		if [ "$1" = "-p" ]; then
			echo "clipping $INPUT to poly..."
			ogr2ogr -clipsrc $MASK polyclip/$INPUT boxclip/$INPUT
			echo "polyclip complete"
		fi
	done
	echo "All clipping complete"

#clip specific file
elif [ "$#" = "3" ]; then
	INPUT=$3
	echo "clipping $INPUT to box..."
	ogr2ogr -f "ESRI Shapefile" -clipsrc $EXTENT boxclip/$INPUT $INPUT
	echo "boxclip complete"
	if [ "$1" = "-p" ]; then
		echo "clipping $INPUT to poly..."
		ogr2ogr -clipsrc $MASK polyclip/$INPUT boxclip/$INPUT
		echo "polyclip complete"
	fi
else 
	echo "please input command -b/-p mask input(optional)"
fi