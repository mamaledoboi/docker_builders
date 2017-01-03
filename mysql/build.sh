cd `dirname $0`

#Refech name of image
IMAGE_NAME=$1
date=`date +%Y%m%d_%H%M%S`
image_name=$IMAGE_NAME:$date
echo "image_name is $image_name"
echo "IMAGE_NAME=$IMAGE_NAME" >> param

#aseemble files to workspace
rm -rf build_env
mkdir build_env
cp param build_env
cp -r add/* build_env
cp Dockerfile build_env
cd build_env

#SYNC_DATA_CMD
#if has, repalce above

#Build docker image
docker build -t $image_name
docker push $image_name
if [[ &? != 0 ]];then
	echo "Fail to push image $image_name";
else
	echo "Success"
fi
