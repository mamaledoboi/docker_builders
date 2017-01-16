source setting.conf

##### goto target dir #####
target_list=$(ls ../conf)
echo "------- choose target --------"
index=-1
for target in ${target_list[@]}
do
  index=$((index+1))
  echo "    [$index]  $target"
done
echo "---------------"

#docker ps|awk '{print $NF}'
echo "which target you want enter[0-$index]："
read target_index
echo "index: $target_index"

#verify target_index
is_exist=0

#goto target dir
index=-1
for target in ${target_list[@]}
do
  index=$((index+1))
  if [ $index = "$target_index" ]; then
    is_exist=1
	cd ../conf/$target
	echo "current path is `pwd`"
  fi
done

#verify fasle,then exit 1
if [[ $is_exist -ne 1 ]];then
    echo "Error for target_index : $target_index"
    exit 1
fi

#Fetch name of container and image
export IMAGE_NAME=`cat $DOCKER_INFO_FILE | grep IMAGE_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "IMAGE_NAME is $IMAGE_NAME"
export CONTAINER_NAME=`cat $DOCKER_INFO_FILE | grep CONTAINER_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "CONTAINER_NAME is $CONTAINER_NAME"

#log
Date=`date "+%Y-%m-%d %H:%M:%S"`
echo "$Date boot IMAGE $IMAGE_NAME" >> ${LOG_FILE}

##### start to boot #####
docker pull ${IMAGE_NAME}
docker rm -f $CONTAINER_NAME

sh $DOCKER_RUN_FILE

if [[ $? != 0 ]];then
    echo "Fail to boot image $IMAGE_NAME";
else
    echo "Boot image $IMAGE_NAME Success"
fi
