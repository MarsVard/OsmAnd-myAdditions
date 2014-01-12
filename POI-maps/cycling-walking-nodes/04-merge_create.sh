#!/bin/bash

# 04-merge_create.sh
# Script to create combined cycle and walking POI maps.
# Split up in to multiple scripts to make it easier to rework things without downloading
# As nodes are sometimes combined cycle and walking nodes we need to split up the work to get them all
# and later combine them 
# Will work on the created osm files from script 03

BASE_MAP="/opt/OpenStreetMap"

cd $BASE_MAP/osm_files/workmap
for COUNTRY in *-cycling-clean.osm
do
    echo "Create pre cycle map osm from $COUNTRY"
    sed -e 's+\t++' -e 's+ lat=+ visible="true" lat=+' -e 's+gpsfietsroute_nl_ref" v="+desc" v="gpsfietsroute_nl_ref +' -e 's+ncn_ref" v="+name" v="fietsknooppunt=+' -e 's+rcn_ref" v="+name" v="fietsknooppunt=+' -e 's+lcn_ref" v="+name" v="fietsknooppunt=+' -e 's+</node>+\t<tag k="tourism" v="information"/>\n</node>+' $COUNTRY > ${COUNTRY%clean.osm}pre.osm
done

for COUNTRY in *-walking-clean.osm
do
    echo "Create pre walking map osm, make node id negative to prevent double nodes between cycle and walking osms from $COUNTRY"
    sed -e 's+\t++' -e 's+node id="+node id="-+' -e 's+ lat=+ visible="true" lat=+' -e 's+nwn_ref" v="+name" v="wandelknooppunt=+' -e 's+rwn_ref" v="+name" v="wandelknooppunt=+' -e 's+lwn_ref" v="+name" v="wandelknooppunt=+' -e 's+k="note"+k="desc"+' -e 's+</node>+\t<tag k="tourism" v="information"/>\n</node>+' $COUNTRY > ${COUNTRY%clean.osm}pre.osm
done

for COUNTRY in *cycling-pre.osm
do
    echo "merge cycle and walking osm files for ${COUNTRY%-cycling-pre.osm}"
    cat $COUNTRY ${COUNTRY%cycling-pre.osm}walking-pre.osm > ${COUNTRY%-cycling-pre.osm}_europe-cycling-walking-nodes.osm
done
