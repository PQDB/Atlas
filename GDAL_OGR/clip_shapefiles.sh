#!/bin/bash
# Jordan Quan, Oct1, 2014

#Place script in desired folder
#Clips shapefiles using a bounding.shp
#Input name of file to clip one, or leave blank to clip all in folder
#The clipped shapefiles are placed in the clipped subdirectory

#args $1: -b=clip to box only, -p=clip to polygon
#args $2: mask.shp
#args $3: input.shp (optional)

mkdir -p ./boxclip
mkdir -p ./polyclip

MASK=$2
INPUT=$3
OUTPUT="output.shp"
#TEMP="temp.shp"
BASE=`basename $MASK .shp`

EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
| sed 's/ - /, /g'`

EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`

echo $EXTENT

ogr2ogr -clipsrc $EXTENT boxclip/$INPUT $INPUT

echo "box clip done"



if false; then
	if [ "$#" = "2" ];then	#clip all files
		for shp in *.shp
		do
			if [ "$1" = "-b" ]; then #using box extents
				echo "clipping $shp to box"
				EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
					| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
					| sed 's/ - /, /g'`
				EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
				ogr2ogr -f "ESRI Shapefile" /boxclip/$shp $shp -clipsrc $EXTENT
				echo "boxclip complete"
			elif [ "$1" = "-p" ]; then
				echo "clipping $shp to box"
				EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
					| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
					| sed 's/ - /, /g'`
				EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
				ogr2ogr -f "ESRI Shapefile" /boxclip/$shp $shp -clipsrc $EXTENT
				echo "boxclip complete"
				echo "clipping $shp to poly"
				ogr2ogr -clipsrc $MASK /polyclip/$shp /boxclip/$shp
				echo "polyclip complete"
			fi
		done
		echo "All clipping complete"
	elif [ "$#" = "3" ]; then
		$INPUT = $3
		if [ "$1" = "-b" ]; then #using box extents
			echo "clipping $3 to box"
			EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
				| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
				| sed 's/ - /, /g'`
			EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
			ogr2ogr -f "ESRI Shapefile" /boxclip/$INPUT $INPUT -clipsrc $EXTENT
			echo "boxclip complete"
		elif [ "$1" = "-p" ]; then
			echo "clipping $shp to box"
			EXTENT=`ogrinfo -so $MASK $BASE | grep Extent \
				| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
				| sed 's/ - /, /g'`
			EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
			ogr2ogr -f "ESRI Shapefile" /boxclip/$INPUT $INPUT -clipsrc $EXTENT
			echo "boxclip complete"
			echo "clipping $shp to poly"
			ogr2ogr -clipsrc $MASK /polyclip/$INPUT /boxclip/$INPUT
			echo "polyclip complete"
		fi
	else 
		echo "please input command -b/-p mask input(optional)"
	fi
fi
