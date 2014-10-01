#!/bin/bash
#Jordan Quan, Oct1, 2014

#Place script in desired folder
#Reprojects shapefiles to EPSG:32198
#Input name of file to convert one, or leave blank to convert all in folder
#The converted shapefiles are place in the converted subdirectory

mkdir -p ./converted

if [ "$#" = "1" ]; then
	echo "Reprojecting $1"
	ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:32198 converted/$1 $1
else
	for shp in *.shp
	do
 		echo "Reprojecting $shp"
 		ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:32198 converted/$shp $shp
	done
fi
