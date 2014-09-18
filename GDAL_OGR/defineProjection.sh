#!/bin/bash

for i in $(ls *.shp); 

do

echo “Begin Processing!”

ogr2ogr -f “ESRI Shapefile” -a_srs “EPSG:32198″ ./projectedShapefiles $i

echo “Processing Done!”

done

#testing...
