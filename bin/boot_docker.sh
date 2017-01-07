source setting.conf

#goto target dir
sh go_target.sh $@
exit $?

#Fetch name of container and image from $param_file
sh fetch_docker_info.sh

docker pull ${IMAGE_NAME}
docker rm -f $CONTAINER_NAME

sh docker_run.sh

if [[ $? != 0 ]];then
    echo "Fail to boot image $IMAGE_NAME";
else
    echo "Boot image $IMAGE_NAME Success"
fi
