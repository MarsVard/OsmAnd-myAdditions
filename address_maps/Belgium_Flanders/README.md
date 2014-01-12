How to create the België, Vlaanderen (Belgium Flanders) address map.

Note: This description is based on a Linux/Unix/BSD type of environment.

This map is based on the work done by Pieter Colpaert (https://github.com/pietercolpaert/crab-tools) who created address csv files based on the CRAB database for download (http://download.agiv.be/Producten/Detail?id=102&title=CRAB_adresposities).



prerequisites: osmconvert, osmfilter, OsmAndMapCreator, python (default on a linux system)

For the prerequisites:
- Download or compile osmconvert (http://wiki.openstreetmap.org/wiki/Osmconvert)
- Download or compile osmfilter (http://wiki.openstreetmap.org/wiki/Osmfilter)
- Download OsmAndMapCreator (http://download.osmand.net/latest-night-build/OsmAndMapCreator-main.zip)


The actual map creation:
- Run the 01-download_convert_BE.sh bash shell script
- Run the 02-convert_be_csv2osm.py python script
- Optionally convert the osm to an osm.pbf file "osmconvert Belgie-Vlaanderen_address.osm --out-pbf > Belgie-Vlaanderen_address.osm.pbf"
- Create the Belgie-Vlaanderen_address.obf from OsmAndMapCreator, either from the Gui or the command line. 
Note that you only need to create the address index and the map index.

To be done: Use the Flanders polygon to make a derived map from Belgium. It will decrease the map size probably with 10-20MB (perhaps more) and it will prevent confusion. Cities outside Flanders will not be in the map and users can't get confused when searching on cities that don't contain streets at all. (Flanders poly already in place. Just waiting for feedback: are users interested or not)
