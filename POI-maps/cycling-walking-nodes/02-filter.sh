#!/bin/bash

# 02-filter.sh
# Script to create combined cycle and walking POI maps.
# Split up in to multiple scripts to make it easier to rework things without downloading
# Will work on the available downloaded and converted maps from script 01

BASE_MAP="/opt/OpenStreetMap"

cd $BASE_MAP/osm_files/workmap
for COUNTRY in *-latest.o5m
do
    echo "filter cycle nodes from $COUNTRY"
    osmfilter $COUNTRY --keep="rcn_ref=" --keep="ncn_ref" --keep="lcn_ref" --drop-ways --drop-relations --out-osm > ${COUNTRY%latest.o5m}cycling.osm
    echo "filter walking nodes from $COUNTRY"
    osmfilter $COUNTRY --keep="rwn_ref" --keep="nwn_ref" --keep="lwn_ref" --drop-ways --drop-relations --out-osm > ${COUNTRY%latest.o5m}walking.osm
done
