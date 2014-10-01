#!/bin/bash
#Jordan Quan, Oct1, 2014

#place script in folder with desired Shapefiles
#run script to merge all files into one

echo "Creating merged.shp"

for foo in *.shp
do
	echo "Merging $foo"
	ogr2ogr -update -append merged.shp $foo -f "ESRI Shapefile" -nln merge
done

#dissolve
#merge features in shapefile by common attribute
ogr2ogr dissolved.shp merged.shp -dialect sqlite -sql "select ST_union(Geometry), common_attribute from input GROUP BY common_attribute"

echo "Resulting file info:"
ogrinfo -al -so dissolved.shp