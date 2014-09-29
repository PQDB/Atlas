#!/bin/bash
#Jordan Quan Sept26, 2014

#place script in folder with desired Vector Shapefiles
#run script to merge all files into one

#echo "Creating mergedVector.shp"

#needs a source file to create?
#ogr2ogr -a_srs EPSG:32198 -f "ESRI Shapefile" mergedVector.shp

for foo in *.shp

do

	echo "Merging $foo"

	ogr2ogr mergedVector.shp $foo

	ogr2ogr -update -append mergedVector.shp $foo -nln $foo

done


#reproject file, must use a new file name
#ogr2ogr -t_srs EPSG:32198 new.shp mergedVector.shp

#echo "Resulting file info:"

#ogrinfo -al -so new.shp

#echo ""