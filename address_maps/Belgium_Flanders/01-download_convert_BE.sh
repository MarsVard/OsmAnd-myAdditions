#!/bin/sh

# version 01, 2014-01-11, Harry van der Wolf

# This shell script will download the latest Belgium osm.pbf
# Then it will convert it to an intermediate format
# Then it will filter all admin boundaries for places (cities, towns, villages, etc.) 
# and put them in a new osm
rm belgium-latest.osm.pbf
wget download.geofabrik.de/europe/belgium-latest.osm.pbf

#osmconvert belgium-latest.osm.pbf --drop-author --out-o5m -o=belgium-latest.o5m
osmconvert belgium-latest.osm.pbf --drop-author -B=Vlaanderen.poly --out-o5m -o=belgium-vlaanderen-latest.o5m

osmfilter belgium-vlaanderen-latest.o5m --keep="boundary=administrative place=" --keep-ways-relations="boundary=administrative" --keep-ways= --keep-nodes= --keep-relations= --out-osm -o=belgium-vlaanderen-boundaries.osm

# finally remove closing osm to be able to merge it with the address osm
cat belgium-vlaanderen-boundaries.osm | grep -v '</osm>' > belgium-vlaanderen-boundaries-modified.osm

