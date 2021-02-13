#!/bin/bash

# update server's data
/home/steam/steamcmd/steamcmd.sh \
	    +login anonymous \
	        +force_install_dir /home/steam/valheim/server \
		    +app_update 896660 \
		        +exit

#Copy 64bit steamclient, since it keeps using 32bit
cp /home/steam/steamcmd/linux64/steamclient.so /home/steam/valheim/server/

#Launch server
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
/home/steam/valheim/server/valheim_server.x86_64 -name "$SERVER_NAME" -port $SERVER_PORT -world "$SERVER_WORLD" -password "$SERVER_PASSWORD" -savedir "$SERVER_SAVE_DIR" -public 1 &

#Trap Container Stop for graceful exit
trap "kill -SIGINT $!;" SIGTERM

#Wait for server to exit
while wait $!; [ $? != 0 ]; do true; done
