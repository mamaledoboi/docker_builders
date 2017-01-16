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

#SYNC_DATA_CMD
#if has, repalce above

#Build
echo "start to build ......"
docker build -t $IMAGE_NAME .

#Push
echo "start to push ......"
docker push $IMAGE_NAME

#Finish
if [[ $? -eq 0 ]];then
	echo " ########### build $IMAGE_NAME Succesfully ########## ";
else 
	echo " ########### build #IMAGE_NAME Failed   ########## ";
fi
