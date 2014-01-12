#!/usr/bin/env python

# version 01, 2014-01-11, Harry van der Wolf
# CRAB csv files have following structure
# PKANCODE,COMMUNE_NL,STREET_NL,HUISNR,LAT,LON

import os, csv, glob

list_of_files = glob.glob('./crab-tools/crab_csv/*.csv')
list_of_files.sort()

# The nodecounter will be decreased to create negative nodes
# negative nodes are nodes not registered in the global OSM database
nodecounter = 0
filestring = ""

for csv_file in list_of_files: 
   print('reading contents of: ' + csv_file)
   with open(csv_file, 'rb') as single_csvfile:
     addressreader = csv.reader(single_csvfile, delimiter=',')
     rowcounter = 0
     for row in addressreader:
         if rowcounter > 0:
            nodecounter -= 1
            filestring += '  <node id="' +str(nodecounter) + '" visible="true" lat="'  + row[4] + '" lon="' +row[5] + '" version="1">\n'
            filestring += '    <tag k="addr:street" v="' + row[2] + '"/>\n'
            filestring += '    <tag k="addr:housenumber" v="' + row[3] + '"/>\n'
            filestring += '    <tag k="addr:postcode" v="' + row[0] + '">\n'
            filestring += '    <tag k="addr:city" v="' + row[1] + '"/>\n'
            # also write the old deprecated is_in tag
            filestring += '    <tag k="is_in" v="' + row[1] + '"/>\n'
            filestring += '  </node>\n'
         rowcounter += 1
# "close" osm filestring
filestring += '</osm>'
print('\n\nNow writing the pre_belgium_europe_address.osm')
text_file = open('pre_belgium_europe_address.osm', 'w')
text_file.write(filestring)
text_file.close()

# Do the merge of both files. This could be in one go (and that would be faster as well)
# But two steps give you the option to check the intermediate files
filenames = ['belgium-boundaries-modified.osm', 'pre_belgium_europe_address.osm']
# As we have big files and don't want memory issues we do it line by line (even though that's also slower)
print('\n\nNow writing the final "Belgie-Vlaanderen_address.osm" which can be used to create the address obf')
with open('Belgie-Vlaanderen_address.osm', 'w') as outputfile:
  for filename in filenames:
      with open(filename) as inputfile:
          for line in inputfile:
              outputfile.write(line)
print('\n\nReady!!')
print('Use the created "Belgie-Vlaanderen_address.osm" to create the Belgium address obf file for OsmAnd')
print('Only use the ADDRESS index and the MAP index')
