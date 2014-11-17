#!/bin/bash

# FILE: upload_shapefiles.sh
# DESC: upload shapefile to PostGIS database
# AUTHOR: Jordan Quan
# LAST REVISED: 2014/11/14

#script must be run using 'sudo -u postgres ./upload_shapefiles.sh'
# uses -W "latin1" cuz of french characters

for shp in *.shp
do
	temp="${shp##*/}" 
	name="${temp%.*}"
    shp2pgsql -s 32198 -W "latin1" $shp public.$name | psql -d AtlasData
done