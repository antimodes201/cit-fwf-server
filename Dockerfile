FROM ubuntu:16.04

MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

USER root

# Set some Variables
ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT "27015"
ENV QUERY_PORT "7777"
ENV STEAM_PORT "8766"
ENV WEB_SERVER "8889"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		wget \
        lib32stdc++6 \
        lib32gcc1 \
        lib32z1 \
        libstdc++6:i386 \
		ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# add steam user
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steam && \
    usermod -G tty steam \
        && mkdir -p /citadel \
        && mkdir -p /steamcmd \
		&& mkdir -p /scripts \
        && chown steam:steam /citadel \
		&& chown steam:steam /steamcmd \
		&& chown steam:steam /scripts 

# install server
USER steam
RUN cd /steamcmd && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz && \
	/steamcmd/steamcmd.sh +quit

# 11.04.19 - moving entire install from Dockerfile into start.sh
# 			 Want to cut down on image size and amount of data to be installed between container restarts.
#RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /citadel +app_update 489650 +quit
 
ADD start.sh /scripts/start.sh
ADD Game.ini /scripts/Game.ini
ADD Engine.ini /scripts/Engine.ini

# Expose some port
EXPOSE ${GAME_PORT}/udp
EXPOSE ${QUERY_PORT}/udp
EXPOSE ${STEAM_PORT}/tcp
EXPOSE ${STEAM_PORT}/udp
EXPOSE ${WEB_SERVER}/tcp
EXPOSE ${WEB_SERVER}/udp

# Make a volume
# contains configs and world saves
VOLUME /citadel

CMD ["/scripts/start.sh"]