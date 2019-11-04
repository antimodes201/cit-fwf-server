#!/bin/bash
# Startup Script for Citadel Forged with Fire Dedicated Server
# Used in conjuncution with Docker Image for service

dirPath=/citadel/Citadel/Saved/Config/LinuxServer
gameini=${dirPath}/Game.ini
engineini=${dirPath}/Engine.ini

if [ ! -f "${gameini}" ]
then
	cp /scripts/Game.ini ${gameini}
fi

if [ ! -f "${engineini}" ]
then
	cp /scripts/Engine.ini ${engineini}
fi

# Check for updates since build
/steamcmd/steamcmd.sh +login anonymous +force_install_dir /citadel +app_update 489650 +quit

# Start Server
/citadel/CitadelServer.sh