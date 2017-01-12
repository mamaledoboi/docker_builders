#!/bin/bash
sudo docker run --detach \
	--hostname gitlab.example.com \
	--env GITLAB_OMNIBUS_CONFIG="external_url 'http://jenkins.tigerson.com/';" \
	--publish 443:443 --publish 8021:80 --publish 22:22 \
    --name $CONTAINER_NAME \
    --restart always \
    --volume /Users/admin/myDockers/datas/gitlab/config:/etc/gitlab \
    --volume /Users/admin/myDockers/datas/gitlab/logs:/var/log/gitlab \
    --volume /Users/admin/myDockers/datas/gitlab/data:/var/opt/gitlab \
	$IMAGE_NAME
