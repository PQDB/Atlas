#!/bin/bash
#Jordan Quan, Oct1, 2014

#place script in folder with desired raster tif files
#run script to merge all files into one

echo "Merging rasters..."
gdal_merge.py -o output.tif `ls *.tif`
#to preserve no data values?
#gdalwarp input1.tif input2.tif merged.tif -srcnodata <nodata_value> -dstnodata <merged_nodata_value>
echo "Finished merging"