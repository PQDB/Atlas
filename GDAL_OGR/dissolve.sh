#!/bin/bash

# FILE: dissolve.sh
# DESC: dissolve features in shapefile by common attribute
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/27

# merges/dissolves features according to common attribute
# maintains all fields
# NOTE: some fields may have become irrelevant, ex: geometries

if [ "$#" != "2" ]; then
	echo "Please input command: input[no suffix] attribute"
else
	INPUT=$1
	ATTR=$2
	BOOL=false
	FIELDS=""
	#grab first word of each line of ogrinfo
	LIST=`ogrinfo -al -so $INPUT.shp | cut -d' ' -f1`
	#remove colon
	LIST="${LIST//:}"
	#now do stupid stuff to get only the field names
	for word in $LIST;
	do
		if [ "${word: -1}" = "," ]; then
			BOOL=true;
			continue
		fi
		#and save only the other fields
		if [ $BOOL = true ] && [ "$word" != "$ATTR" ]; then
			FIELDS="$FIELDS, $word"
		fi
	done

	echo "Dissolving by $ATTR..."
	ogr2ogr dissolved.shp $INPUT.shp -dialect sqlite -sql "select ST_Union(Geometry), $ATTR$FIELDS from $INPUT GROUP BY $ATTR"
fi