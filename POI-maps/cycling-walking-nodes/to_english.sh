#/bin/bash

BASE_MAP="/opt/OpenStreetMap/osm_files/workmap"

mkdir -p $BASE_MAP/english

cd $BASE_MAP
for osmfile in *europe*.osm
do
    sed -e 's+fietsknooppunt+cycle_node+' -e 's+wandelknooppunt+walking_node+' $osmfile > $BASE_MAP/english/$osmfile
done 
