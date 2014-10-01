#!/bin/bash
# Jordan Quan, Oct1, 2014

#Place script in desired folder
#Clips shapefiles using a bounding.shp
#Input name of file to clip one, or leave blank to clip all in folder
#The clipped shapefiles are placed in the clipped subdirectory

#args: $1=bounds, $2=input

mkdir -p ./clipped

if [ "$#" = "1" ];then
	for shp in *.shp
	do
 		echo "Clipping $shp"
 		ogr2ogr -clipsrc $1 ./clipped/$shp $shp
	done
else if [ "$#" = "2" ]; then
	echo "Clipping $2"
	ogr2ogr -clipsrc $1 ./clipped/$2 $2
else 
	echo "please specify bounding shapefile [and input]"
fi
