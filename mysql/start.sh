IMAGE_NAME=`cat param | grep IMAGE_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "IMAGE_NAME is $IMAGE_NAME"
CONTAINER_NAME=`cat param | grep CONTAINER_NAME | tail -1 | awk -F '=' '{print $2}'CONTAINER_NAME`
echo "CONTAINER_NAME is $CONTAINER_NAME"

#docker pull ${image_name}
docker rm -f $CONTAINER_NAME

docker run --detach \
	--hostname docker.container \
	--restart always \
	--name $CONTAINER_NAME \
	--publish 3306:3306 \
	--env TZ=Asia/Shanghai \
	--env LANG=en_US.UTF-8 \
	-v /Users/admin/myDockers/datas/mysql:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=qwer1234 \
	$IMAGE_NAME
