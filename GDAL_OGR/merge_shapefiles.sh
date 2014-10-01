#!/bin/bash
#Jordan Quan Sept26, 2014

#place script in folder with desired Shapefiles
#run script to merge all files into one

echo "Creating merged.shp"

for foo in *.shp
do
	echo "Merging $foo"
	ogr2ogr -update -append merged.shp $foo -f "ESRI Shapefile" -nln merge
done

echo "Resulting file info:"
ogrinfo -al -so merged.shp