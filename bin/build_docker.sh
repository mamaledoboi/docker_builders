#Usage
TARGET=$1
USAGE="usage: sh build_docker.sh [TARGET] "
if [[ $@ -ne 1 ]];then
	echo "${USAGE}"
	exit;
fi

#go to location
cd ../conf/${TARGET}
if [[ $? -ne 0 ]];then
	echo "Error target for ${TARGET}"
	exit
fi

#Fetch name of container and image 
IMAGE_NAME=`cat param | grep IMAGE_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "IMAGE_NAME is $IMAGE_NAME"
CONTAINER_NAME=`cat param | grep CONTAINER_NAME | tail -1 | awk -F '=' '{print $2}'CONTAINER_NAME`
echo "CONTAINER_NAME is $CONTAINER_NAME"

#log
Date=`date "+%Y-%m-%d %H:%M:%S"`
echo "IMAGE_NAME is $IMAGE_NAME"
echo "$Date IMAGE_NAME=$IMAGE_NAME" >> param

#Build env
rm -rf build_env
mkdir build_env
cp param build_env
cp Dockerfile build_env
cd build_env

#SYNC_DATA_CMD
#if has, repalce above

#Build
echo "start to build ......"
docker build -t $IMAGE_NAME .

#Push
echo "start to push ......"
docker push $IMAGE_NAME

#Finish
echo " ########### Finished ########## "
