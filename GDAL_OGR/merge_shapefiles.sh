#!/bin/bash

# FILE: merge_shapefiles.sh
# DESC: merge all shapefiles in folder
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/20

#create initial merged.shp
for first in *.shp
do
	echo "Creating merged.shp from $first"
	ogr2ogr -f "ESRI Shapefile" merged.shp $first
	break
done

for foo in *.shp
do
	#append with remaining .shp's
	if [ "$foo" != "$first" ] && [ "$foo" != "merged.shp" ]
	then
		echo "Merging $foo..."
		ogr2ogr -update -append merged.shp $foo -nln merged
	fi
done

echo "Resulting file info:"
ogrinfo -al -so merged.shp