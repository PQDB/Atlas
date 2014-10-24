#!/bin/bash

# FILE: merge_raster.sh
# DESC: merges all tif's in folder
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/10/24

#may need to manually save style from input and apply to output afterwards

echo "Merging rasters..."
gdal_merge.py -o output.tif `ls *.tif`
echo "Finished merging"