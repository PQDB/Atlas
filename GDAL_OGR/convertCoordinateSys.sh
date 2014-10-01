#!/bin/bash
#Jordan Quan Sept26, 2014

#OLD(cleaned and renamed), REMOVE

#place script in desired folder
#run script to convert coordinate system of all .shp files to Quebec Lambert
#converted files will be placed in a new sub folder

for foo in *.shp

do

 echo "Converting $foo"

 ogr2ogr -overwrite -t_srs EPSG:32198 "./Conversions/$foo" $foo

 echo "Done converting $foo"

 echo "Resulting file info:"

 ogrinfo -al -so "./Conversions/$foo"

 echo ""

done
