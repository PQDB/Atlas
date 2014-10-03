#!/bin/bash

#Place script in desired folder
#Reprojects shapefiles to EPSG:32198
#Input name of file to convert one, or leave blank to convert all in folder
#The converted shapefiles are place in the converted subdirectory

mkdir -p ./converted

#possible inputs: none, -r, -r file, file

if [ "$#" = "0" ]; then														#no args, reproject all
	for foo in *.tif
	do
		echo "Reprojecting $foo..."
		gdalwarp -t_srs EPSG:32198 converted/$foo $foo
	done
elif [ "$# " = "2" ] && [ "$1" = "-r" ]; then								#2args, first is r, repoject specific using bilinear
	echo "Reprojecting $2..."
	gdalwarp -r bilinear -t_srs EPSG:32198 converted/$2 $2
elif [ "$#" = "1" ]; then													#1arg
	if [ "$1" = "-r" ]; then												#arg is r, repoject all using bilinear
		for foo in *.tif
		do
			echo "Reprojecting $foo..."
			gdalwarp -r bilinear -t_srs EPSG:32198 converted/$foo $foo
		done
	else																	#1arg, not r, reproject specific
		echo "Reprojecting $1..."
		gdalwarp -t_srs EPSG:32198 converted/$1 $1
	fi
else
	echo "error: incorrect input"
fi

echo "Reprojection complete"