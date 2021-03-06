#####################################
##################### BUILD PHASE ###
#####################################

#########################
### Alpine Base image ###
#########################

FROM alpine:3.11 AS build
LABEL maintainer ="s1mmel <mc_simmel@hotmail.com>"

#################
### Arguments ###
#################

### openjdk Java image Version
ARG APK_JAVA=openjdk11-jre-headless
### APK local repo
ARG APK_REPO="http://ftp.halifax.rwth-aachen.de/alpine/v3.11/community/"
### Minecraft Version to download and patch
ARG MC_VERSION=1.15.2
### Download API from Papermc
ARG PAPER_API=https://papermc.io/api/v1/paper/${MC_VERSION}/latest/download

#####################
### ENV Variables ###
#####################

### mc server path
ENV MINECRAFT_PATH=/opt/srv/minecraft

### Working directory
WORKDIR ${MINECRAFT_PATH}

### Download paperclip
ADD ${PAPER_API} paper.jar

RUN apk add --no-cache ${APK_JAVA} ca-certificates --repository=${APK_REPO}

### Run paperclip and patch it
### Copy built jar
RUN java -jar ${MINECRAFT_PATH}/paper.jar; exit 0
RUN mv ${MINECRAFT_PATH}/cache/patched*.jar ${MINECRAFT_PATH}/paper.jar

#################################################
######################### Runtime Environment ###
#################################################

#########################
### Alpine Base image ###
#########################

FROM alpine:3.11 AS runtime
LABEL maintainer ="s1mmel <mc_simmel@hotmail.com>"

#################
### Arguments ###
#################

### openjdk Java image Version
ARG APK_JAVA=openjdk11-jre-headless
### APK local repo
ARG APK_REPO="http://ftp.halifax.rwth-aachen.de/alpine/v3.11/community/"

#############################
### Environment Variables ###
#############################
ENV USER=minecraft
ENV UID=9999
ENV GID=9999
ENV MINECRAFT_PATH=/opt/srv/minecraft
ENV SERVER_PATH=${MINECRAFT_PATH}/server
ENV DATA_PATH=${MINECRAFT_PATH}/data
ENV LOGS_PATH=${MINECRAFT_PATH}/logs
ENV CONFIG_PATH=${MINECRAFT_PATH}/config
ENV WORLDS_PATH=${MINECRAFT_PATH}/worlds
ENV PLUGINS_PATH=${MINECRAFT_PATH}/plugins
ENV PROPERTIES=${CONFIG_PATH}/server.properties
ENV JAVA_HEAP_SIZE=4G
ENV JAVA_ARGS="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -Dusing.aikars.flags=mcflags.emc.gs -server -Dcom.mojang.eula.agree=true"
ENV SPIGOT_ARGS="--nojline"
ENV PAPER_ARGS=""
ENV LANG=C.UTF-8
ENV TZ=Europe/Berlin


RUN apk add --no-cache py3-pip ${APK_JAVA} ca-certificates tzdata tini bash --repository=${APK_REPO} &&\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

### Working directory
WORKDIR ${SERVER_PATH}

### Get patched jar
COPY --from=build /opt/srv/minecraft/paper.jar ${SERVER_PATH}/

### make MC-User and group
### make dirs & chown them (plus jar file in folder) to user
### add py-pip to get mcstatus for healthchecking

RUN addgroup "$USER" --gid "$GID" &&\
    adduser --disabled-password --gecos "" --home "$(pwd)" --ingroup "$USER" --no-create-home --uid "$UID" "$USER" &&\
    mkdir ${LOGS_PATH} ${DATA_PATH} ${WORLDS_PATH} ${PLUGINS_PATH} ${CONFIG_PATH} && \
    chown -R ${USER}:${USER} ${MINECRAFT_PATH} &&\
    pip3 install mcstatus

### Healthcheck with MCstatus
HEALTHCHECK --interval=10s --timeout=5s --start-period=120s \
    CMD mcstatus localhost:$( cat $PROPERTIES | grep "server-port" | cut -d'=' -f2 ) ping

### Obtain scripts
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER ${USER}

### Setup environment ###

# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
RUN ln -s $PLUGINS_PATH $SERVER_PATH/plugins && \
    # Create symlink for persistent data
    ln -s $DATA_PATH/banned-ips.json $SERVER_PATH/banned-ips.json && \
    ln -s $DATA_PATH/banned-players.json $SERVER_PATH/banned-players.json && \
    ln -s $DATA_PATH/help.yml $SERVER_PATH/help.yml && \
    ln -s $DATA_PATH/ops.json $SERVER_PATH/ops.json && \
    ln -s $DATA_PATH/permissions.yml $SERVER_PATH/permissions.yml && \
    ln -s $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json && \
    # Create symlink for logs
    ln -s $LOGS_PATH $SERVER_PATH/logs

###############
### Volumes ###
###############
VOLUME "${CONFIG_PATH}"
VOLUME "${WORLDS_PATH}"
VOLUME "${PLUGINS_PATH}"
VOLUME "${DATA_PATH}"
VOLUME "${LOGS_PATH}"

#############################
### Expose minecraft port ###
#############################
EXPOSE 25565

######################################
### Entrypoint is the start script ###
######################################
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/sbin/tini", "--"]
