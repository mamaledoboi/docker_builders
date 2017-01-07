#list all available targets
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
echo "which target you want enter[1-$index]："
read target_index
echo "index: $target_index"

#verify target_index
is_exist=0

#goto target dir
index=-1
for target in ${target_list[@]}
do
  index=$((index+1))
  if [ $index = "$docker_index" ]; then
	is_exist=1
    echo $target
    cd ../conf/$target
  fi
done

#verify fasle,then exit 1
if [[ $is_exist -ne 1 ]];then
	echo "Error for target_index : $target_index"
	exit 1
fi
