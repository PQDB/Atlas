#!/bin/bash
#Jordan Quan Sept29, 2014

#Place script in desired folder
#Convert all shapefiles in current directory to EPSG:32198 projection
#The converted shapefiles are place in the converted subdirectory

mkdir -p ./converted

for shp in *.shp
do
 echo "Processing $shp"
 ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:32198 converted/$shp $shp
done