cd `dirname $0`

#Read name of files
IMAGE_NAME=`cat param | grep IMAGE_NAME | tail -1 | awk -F '=' '{print $2}'`
echo "IMAGE_NAME is $IMAGE_NAME"
CONTAINER_NAME=`cat param | grep CONTAINER_NAME | tail -1 | awk -F '=' '{print $2}'CONTAINER_NAME`
echo "CONTAINER_NAME is $CONTAINER_NAME"

#Record
Date=`date "+%Y-%m-%d %H:%M:%S"`
echo "IMAGE_NAME is $IMAGE_NAME"
echo "$Date IMAGE_NAME=$IMAGE_NAME" >> param

#aseemble files to workspace
rm -rf build_env
mkdir build_env
cp param build_env
cp Dockerfile build_env
cd build_env

#SYNC_DATA_CMD
#if has, repalce above

#Build
docker build -t $IMAGE_NAME .

#Push
docker push $IMAGE_NAME
