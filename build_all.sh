#!/bin/bash

[ "$1" = "--no-cache" ] && no_cache="$1"
find . -name "Dockerfile" -follow |
while read f;do
  ./build.sh $f $no_cache
done
