#!/bin/bash

set -e

SPARK_VERSION="$(curl -s http://mirror.synyx.de/apache/spark/ | grep -oP 'spark-\K(\d\.\d\.\d)(?=/)' |  sort --version-sort | tail -1)"

echo $SPARK_VERSION

HADOOP_VERSION="$(curl -s http://apache.lauf-forum.at/hadoop/common/ | grep -oP '(\d+\.\d+\.\d+)(?=/)' | sort --version-sort | tail -1)"

echo $HADOOP_VERSION

if [ ! -f config/id_rsa ]; then
    sh config/genkey.sh
fi

if [ -f build.out ]; then
    rm build.out
fi

docker build -t spark-base \
    --build-arg SPARK_VERSION=$SPARK_VERSION \
    --build-arg HADOOP_VERSION=$HADOOP_VERSION . \
    | while read line; do echo "$(date +%s) $line"; done \
     > build.out 2>&1 &

timeout 5 tail -f build.out
# (timeout 5 cat build.out || : ) | tail
