source setting.conf

#Fetch name of container and image

export IMAGE_NAME=`cat $DOCKER_INFO_FILE | grep IMAGE_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "IMAGE_NAME is $IMAGE_NAME"

export CONTAINER_NAME=`cat $DOCKER_INFO_FILE | grep CONTAINER_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "CONTAINER_NAME is $CONTAINER_NAME"

#log
Date=`date "+%Y-%m-%d %H:%M:%S"`
echo "IMAGE_NAME is $IMAGE_NAME"
echo "$Date IMAGE_NAME=$IMAGE_NAME" >> ${LOG_FILE}
