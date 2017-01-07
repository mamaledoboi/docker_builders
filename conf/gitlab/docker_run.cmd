docker run --detach \
     --hostname docker.nexus \
     --restart always \
     --name $CONTAINER_NAME \
     --publish 8081:8081 \
     --env TZ=Asia/Shanghai \
     --env LANG=en_US.UTF-8 \
     -v ${DATA_BASE_DIR}/nexus-data:/nexus-data \
