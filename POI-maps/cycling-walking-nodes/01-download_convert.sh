#!/bin/bash

# Script to create combined cycle and walking POI maps.
# Split up in to multiple scripts to make it easier to rework things without downloading

# Simply enter the numbers of countries here; can be one or a lot of countries
#COUNTRIES="belgium british-isles france germany netherlands switzerland denmark norway sweden finland spain portugal"
# For the time being only Belgium and Netherlands work OK. Sweden, Denmark partially
COUNTRIES="belgium denmark netherlands sweden switzerland"
BASE_MAP="/opt/OpenStreetMap"


for COUNTRY in $COUNTRIES
do
    mkdir -p $BASE_MAP/osm_files/workmap
    cd $BASE_MAP/osm_files/workmap
    #rm -f $COUNTRY-latest.osm.pbf
    # Use wget -c : It continues a broken download
    # but make sure that the map is not updated in the mean time or you will get a corrupted map
    wget -c download.geofabrik.de/europe/$COUNTRY-latest.osm.pbf
    echo "osmconverting  $COUNTRY-latest.osm.pbf"
    osmconvert $COUNTRY-latest.osm.pbf --drop-author --out-o5m > $COUNTRY-latest.o5m
done
