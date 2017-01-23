#!/bin/bash
sudo docker run --detach \
	--hostname artifactory.tigerson.com \
	--publish 8090:8080 \
    --name $CONTAINER_NAME \
    --restart always \
    --volume ~/myDockers/datas/artifactory/data:/artifactory/data \
    --volume ~/myDockers/datas/artifactory/logs:/artifactory/logs \
    --volume ~/myDockers/datas/artifactory/backup:/artifactory/backup \
	$IMAGE_NAME
