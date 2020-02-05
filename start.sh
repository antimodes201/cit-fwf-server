#!/bin/bash
# Startup Script for Citadel Forged with Fire Dedicated Server
# Used in conjuncution with Docker Image for service

if [ ${BRANCH} == public ]
then
        # GA Branch
        /steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 489650 +quit
else
        # used specified branch
        /steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 489650 -beta ${BRANCH} +quit
fi

dirPath=/app/Citadel/Saved/Config/LinuxServer
gameini=${dirPath}/Game.ini
engineini=${dirPath}/Engine.ini
checkBoot=/app/checkBoot

if [ ! -f "${checkBoot}" ]
then
	rm ${gameini}
	rm ${engineini}
	cp /scripts/Game.ini ${gameini}
	cp /scripts/Engine.ini ${engineini}
	printf "Config Written In\n" > ${checkBoot}
fi

cp /steamcmd/linux64/steamclient.so /app/Citadel/Plugins/UWorks/Source/ThirdParty/Linux/steamclient.so

# Start Server
/app/CitadelServer.sh