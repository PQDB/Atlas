#!/bin/bash

# FILE: convert_shapefiles.sh
# DESC: reproject shapefiles to Quebec Lambert EPSG:32198
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/24

#Input name of file to convert one, or leave blank to convert all in folder
#The converted shapefiles are place in the converted subdirectory

mkdir -p ./converted

if [ "$#" = "1" ]; then
	echo "Reprojecting $1..."
	ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:32198 converted/$1 $1
else
	for shp in *.shp
	do
 		echo "Reprojecting $shp..."
 		ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:32198 converted/$shp $shp
	done
fi
echo "Reprojection complete"