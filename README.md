# cit-fwf-server
Docker container for an Citadel: Forged with Fire
 
Build to create a containerized version of the dedicated server for Citadel: Forged with Fire
https://store.steampowered.com/app/487120/Citadel_Forged_with_Fire/


Build by hand
```
git clone https://github.com/antimodes201/cit-fwf-server.git
docker build -t antimodes201/cit-fwf-server:latest .
```

Docker Pull
```
docker pull antimodes201/cit-fwf-server
```

Docker Run with defaults
change the volume options to a directory on your node (volume /app)

```
docker run -it -p 27015:27015/udp -p 7777:7777/udp -p 8766:8766/udp -p 8889:8889/tcp -p 8889:8889/udp -v /app/docker/temp-vol:/app \
	--name cit \
	antimodes201/cit-fwf-server:latest
```

After first boot stop the container and open your mounted volume.  All server properties can be found here under Citadel/Saved/Config/LinuxServer.  Additional launch arguments can be passed using -E ADDITIONAL_ARGS
 
```
docker run -it -p 27015:27015/udp -p 7777:7777/udp -p 8766:8766/udp -p 8889:8889/tcp -p 8889:8889/udp -v /app/docker/temp-vol:/app \
	--e ADDITIONAL_ARGS="-logs" \
	--name cit \
	antimodes201/cit-fwf-server:latest
```
 
Currently exposed environmental variables and their default values
- GAME_PORT 27015
- QUERY_PORT 7777
- STEAM_PORT 8766
- WEB_SERVER 8889
- TZ America/New_York
