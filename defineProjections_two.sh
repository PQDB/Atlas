#!/bin/bash

for shp in *.shp

do

echo “Processing $shp”

ogr2ogr -f “ESRI Shapefile” -t_srs EPSG:32198 geo/$shp $shp

echo "Done Processing $shp"

echo "Resulting Shapefile info:"

ogrinfo -al -so $shp.shp

done