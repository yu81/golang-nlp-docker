#!/bin/bash

target_file=$1
[ ! -s "$target_file" ] && exit 1

[ "$2" = "--no-cache" ] && no_cache="$2"

go_version=$(echo $target_file | awk -F"/" '{print $(NF-2)}')
if [ "$go_version" != "latest" -a $(echo "$go_version" | awk -F"." '{print NF;}' ) = 2 ]; then
  go_version="$go_version".0
fi

distribution=$(echo $target_file | awk -F"/" '{print $(NF-1)}')
[ "$distribution" = "debian" ] && distribution="stretch"

image_name=$(echo "yu81/golang-nlp:"$go_version-$distribution)
echo "will build image of" $image_name

pushd $(dirname $target_file)
docker build -t $image_name . ${no_cache}
if [ $? != 0 ]; then
  popd
  exit 2 
fi
popd

