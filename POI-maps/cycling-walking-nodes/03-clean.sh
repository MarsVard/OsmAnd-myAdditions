#!/bin/bash

# 03-clean.sh
# Script to create combined cycle and walking POI maps.
# Split up in to multiple scripts to make it easier to rework things without downloading
# As nodes are sometimes combined cycle and walking nodes we need to split up the work to get them all
# and later combine them 
# Will work on the osm files created by the 02 script

# Simply enter the numbers of countries here; can be one or a lot of countries
#COUNTRIES="belgium british-isles france germany netherlands switzerland denmark norway sweden finland spain portugal"
BASE_MAP="/opt/OpenStreetMap"

cd $BASE_MAP/osm_files/workmap
for COUNTRY in *-cycling.osm
do
    echo "clean cycle nodes file and remove end </osm> tag from $COUNTRY"
    cat $COUNTRY  | grep -v '<node id=.*/>' | grep -v network | grep -v nwn | grep -v rwn | grep -v lwn | grep -v source_rcn | grep -v source_rwn | grep -v AND_node | grep -v '</osm>' > ${COUNTRY%.osm}-clean.osm
done

for COUNTRY in *-walking.osm
do
    echo "clean walking nodes file and remove first 3 osm lines from $COUNTRY"
    cat $COUNTRY | grep -v 'xml version' | grep -v 'osm version' | grep -v 'bounds min' | grep -v '<node id=.*/>' | grep -v network | grep -v ncn | grep -v rcn | grep -v lcn | grep -v source | grep -v gpsfietsroute_nl_ref | grep -v highway | grep -v AND_node > ${COUNTRY%.osm}-clean.osm
done
