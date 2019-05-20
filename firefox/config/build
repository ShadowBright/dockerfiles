#!/bin/bash

image_name="firefox"

docker system prune -f

if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then

    read -p "Remove previous build [y/(n)]?" choice
    case "$choice" in
           y|Y ) sh remove.sh $image_name;;
              n|N ) echo "Not removing previous build...";;
                 * ) echo "Not removing previous build...";;
                   esac
fi

docker build -t $image_name . \
    > build.out 2>&1 &

tail -f build.out

