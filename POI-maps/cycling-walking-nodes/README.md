How to create the cycling and walking nodes POI maps.

version 01: Only working for the Netherlands and Belgium

Note: This description is based on a Linux/Unix/BSD type of environment.

prerequisites: osmconvert, osmfilter, OsmAndMapCreator

For the prerequisites:
- Download or compile osmconvert (http://wiki.openstreetmap.org/wiki/Osmconvert)
- Download or compile osmfilter (http://wiki.openstreetmap.org/wiki/Osmfilter)
- Download OsmAndMapCreator (http://download.osmand.net/latest-night-build/OsmAndMapCreator-main.zip)


The actual map creation:
- Run the "01-download_convert.sh" script. It will download the countries specified and convert them to a workable format.
- Run the "02-filter.sh" script. It will extract the necessary node tags from the itermediate file from 01.
- Run the "03-clean.sh" script. It will remove a lot of unneccessary or even conflicting tags.
- Run the "04-merge_create.sh" script. This will create the final osm files to create the maps
- Run OsmAndMapCreator, either from the GUI or the command line, to create the desired obf POI maps from the osm files created from the 04 script. Note that you only need to use the POI index when creating the map.



Note: the "to_english.sh" script will simply convert the Dutch "fietsknooppunt" and "wandelknooppunt" to "cycle node" and "walking node" from the osm files produced by the 04 script.
