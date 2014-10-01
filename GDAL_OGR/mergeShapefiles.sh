#!/bin/bash/
# OLD REMOVE

DATA=`find . -name '*.shp'`

ogr2ogr -a_srs EPSG:32198 mergedShapeFile.shp


for i in $DATA

do
ogr2ogr -append -update mergedShapeFile.shp $i -f "Esri Shapefile"


done
