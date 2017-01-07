source setting.conf

#goto target dir
sh go_target.sh $@
exit $?

#Fetch name of container and image from $param_file
sh fetch_docker_info.sh

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
