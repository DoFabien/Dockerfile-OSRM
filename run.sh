#!/bin/bash
DATA_PATH=${DATA_PATH:="/data"}

#mkdir -p /data



if [ ${FILE_OSM:(-8)} = ".osm.pbf" ]
then
echo ".osm.pbf!"
OSM_NAME=${FILE_OSM: 0:(-8)}

elif [ ${FILE_OSM:(-4)} = ".osm" ]
then
echo ".osm!"
OSM_NAME=${FILE_OSM: 0:(-4)}

else
 echo "osm.pbf OU osm uniquement"
fi


echo $OSM_NAME


mkdir -p /data/profiles
mv /src/profiles/*.lua /data/profiles/
rm -R /src

if [ ! -d /data/$OSM_NAME/$PROFILE_LUA ]
then
mkdir -p /data/$OSM_NAME/$PROFILE_LUA
fi

if [ -e /data/$OSM_NAME/$PROFILE_LUA/$OSM_NAME.osrm ] && [ $REFRESH != 1 ]
then
echo "rien"
else
./osrm-extract  /data/$FILE_OSM -p /data/profiles/$PROFILE_LUA

mv /data/$OSM_NAME.osrm /data/$OSM_NAME/$PROFILE_LUA/
mv /data/$OSM_NAME.osrm.names /data/$OSM_NAME/$PROFILE_LUA/
mv /data/$OSM_NAME.osrm.restrictions /data/$OSM_NAME/$PROFILE_LUA/
mv /data/$OSM_NAME.osrm.timestamp /data/$OSM_NAME/$PROFILE_LUA/

./osrm-prepare  /data/$OSM_NAME/$PROFILE_LUA/$OSM_NAME.osrm

fi


  ./osrm-routed  /data/$OSM_NAME/$PROFILE_LUA/$OSM_NAME.osrm
