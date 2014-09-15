#!/bin/bash

for shp in *.shp

do

echo “Converting $shp”

ogr2ogr -t_srs EPSG:32198 $shp.shp $shp.shp

echo "Done Processing $shp"

echo "Resulting Shapefile info:"

ogrinfo -al -so $shp.shp

done
