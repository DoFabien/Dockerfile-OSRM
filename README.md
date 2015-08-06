# Dockerfile-OSRM

Dockerfile pour déployer OSRM sur des profiles et des données différentes

###Build
sudo docker build -t dofabien/osrm .

###Les paramètres
Les données OSM (.osm ou osm.pbf) dans le conteneur se trouvent dans /data. Pour chaque fichier OSM préparé avec un profile un répertoire et un sous répertoire est créé:
Exemple: On utilise le fichier "rhone-alpes-latest.osm.pbf" avec le profile "foot.lua".
Le répertoire rhone-alpes-latest/foot.lua sera créé pour stocker les fichiers utilisé par OSRM (.osrm, .hsgr, .edges, .nodes, etc.)

Les fichiers contenant les profiles (car.lua, foot.lua,etc...) se trouvent dans /data/profiles/

 -e PROFILE_LUA= profile_à_utiliser
 
 -e FILE_OSM = fichier osm.pbf ou osm à utiliser
 
 -e REFRESH = 1 => les données sont re-préparées à partir des données de base. Sinon et si elles ont déjà été préparées, on repart sur ces dernières.

###Executer le conteneur
sudo docker run -d -p 5000:5000 -v /var/data:/data --name=osrm_rhone-alpes_car -e PROFILE_LUA=car.lua  -e FILE_OSM=rhone-alpes-latest.osm.pbf -e REFRESH=0 dofabien/osrm

Pour accéder au log: 
sudo docker logs -f osrm_rhone-alpes_car
