#!/bin/bash

find . -name "Dockerfile" -follow |
while read f;do
  ./push.sh $f
done
