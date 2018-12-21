FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y build-essential git cmake pkg-config \
libbz2-dev libxml2-dev libzip-dev libboost-all-dev \
lua5.2 liblua5.2-dev libtbb-dev
 
  RUN mkdir -p ~/src
  RUN \
  git clone  https://github.com/Project-OSRM/osrm-backend.git ~/src && \
  mkdir -p ~/src/build && \
  cd ~/src/build && \
  cmake .. && \
  cmake --build . && \
  cmake --build . --target install && \
  cp -rL ~/src/profiles/ ./  && \ 
  echo 'disk=/data/stxxl,0,syscall' > ~/src/build/.stxxl
 
 ADD run.sh /usr/bin/run.sh
 RUN chmod 755 /usr/bin/run.sh
 RUN mkdir -p /data/profiles/lib
 RUN chmod -R 777 /data
 RUN cd /data 

VOLUME /data
 





ENV PROFILE_LUA car.lua
ENV FILE_OSM null
ENV REFRESH 0



WORKDIR ~/src/build
# ADD run.sh ~/src/build/run.sh
# RUN chmod 755 ~/src/build/run.sh
EXPOSE 5000
CMD run.sh