#!/bin/bash

target_file=$1
[ ! -s "$target_file" ] && exit 1

go_version=$(echo $target_file | awk -F"/" '{print $(NF-2)}')
if [ "$go_version" != "latest" -a $(echo "$go_version" | awk -F"." '{print NF;}' ) = 2 ]; then
  go_version="$go_version".0
fi

distribution=$(echo $target_file | awk -F"/" '{print $(NF-1)}')
[ "$distribution" = "debian" ] && distribution="stretch"

image_name=$(echo "yu81/golang-nlp:"$go_version-$distribution)
echo "will push image of" $image_name

docker push $image_name
if [ $? != 0 ]; then
  exit 2 
fi

