#!/bin/bash

# FILE: upload_raster.sh
# DESC: upload raster to PostGIS database
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/11/17

#script must be run using 'sudo -u postgres ./upload_raster.sh'
# -C applies raster constraints for proper display
# -t creates tile rows of 128x128
# -I adds spatial reference index
# -s 32198 specifies spatial reference system as Quebec Lambert

for tif in *.tif
do
	temp="${tif##*/}" 
	name="${temp%.*}"
    raster2pgsql -I -C -t 128x128 -s 32198 $tif public.$name | psql -d AtlasData
done
