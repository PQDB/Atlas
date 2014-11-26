#!/bin/bash

mkdir -p ./nodata

for tif in *.tif
do
echo "removing nodata from $tif..."
gdal_translate -a_nodata 0 $tif  nodata/$tif
done
echo "finished removing nodata from all files"
