#!/bin/bash

image_name="firefox"

docker system prune -f

if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then

    read -p "Remove previous build [y/(n)]?" choice
    case "$choice" in
           y|Y ) sh config/remove.sh $image_name;;
              n|N ) echo "Not removing previous build...";;
                 * ) echo "Not removing previous build...";;
                   esac
fi

start_time=$(date +%s)

docker build -t $image_name . \
    | while read line; do echo "$((`date +%s` - $start_time)) $line"; done \
          > build.out 2>&1 | tee build.out &

cat build.out

