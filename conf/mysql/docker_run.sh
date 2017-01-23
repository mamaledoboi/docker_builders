#!/bin/bash
source ../../bin/setting.conf
docker run --detach \
	--hostname mysql.tigerson.com \
	--name $CONTAINER_NAME \
	--publish 3306:3306 \
	--env TZ=Asia/Shanghai \
	--env LANG=en_US.UTF-8 \
	-v $DATA_BASE_DIR/mysql/data:/var/lib/mysql \
	-v $DATA_BASE_DIR/mysql/custom:/etc/mysql/conf.d \
	-e MYSQL_ROOT_PASSWORD=qwer1234 \
	$IMAGE_NAME
