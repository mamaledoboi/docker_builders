#!/bin/bash
docker run --detach \
	--hostname docker.gitlab \
    --restart always \
    --name $CONTAINER_NAME \
    --publish 2222:2222 \
    --publish 443:443 \
    --publish 8021:8021 \
    --env TZ=Asia/Shanghai \
    --env LANG=en_US.UTF-8 \
    -v /Users/admin/myDockers/datas/gitlab:/gitlab-data \
	$IMAGE_NAME
