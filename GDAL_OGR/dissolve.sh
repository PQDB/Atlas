#!/bin/bash

# FILE: dissolve.sh
# DESC: dissolve features in shapefile by common attribute
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/22

#need to retest

if [ "$#" != "2" ]; then
	echo "Please input command: input[no suffix] attribute"
else
	INPUT=$1
	ATTR=$2
	echo "Dissolving by $ATTR..."
	ogr2ogr dissolved.shp $INPUT.shp -dialect sqlite -sql "select ST_Union(Geometry), $ATTR from $INPUT GROUP BY $ATTR"
fi