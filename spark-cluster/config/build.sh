#!/bin/bash

docker system prune -f

set -e

SPARK_VERSION="$(curl -s http://mirror.synyx.de/apache/spark/ | grep -oP 'spark-\K(\d\.\d\.\d)(?=/)' |  sort --version-sort | tail -1)"

echo "SPARK version : $SPARK_VERSION"

HADOOP_VERSION="$(curl -s http://apache.lauf-forum.at/hadoop/common/ | grep -oP '(\d+\.\d+\.\d+)(?=/)' | sort --version-sort | tail -1)"

echo "HADOOP version: $HADOOP_VERSION"

SCALA_VERSION="$(curl -s https://www.scala-lang.org/blog/announcements/ | grep -oP '(?<=Scala )(\d+\.\d+\.\d+)(?= is.*)' | head -1)"

echo "SCALA version: $SCALA_VERSION"

SBT_VERSION="$(curl -s https://github.com/sbt/sbt/releases | grep -oP "(?<=v)(\d+\.\d+\.\d+)(?=\""")" | uniq | head -1)"

echo "SBT version: $SBT_VERSION"

if [ ! -f config/id_rsa ]; then
    sh config/genkey.sh
fi

if [ -f build.out ]; then
    rm build.out
fi

start_time=$(date +%s)

docker build -f $1 -t spark-base \
    --build-arg SPARK_VERSION=$SPARK_VERSION \
    --build-arg HADOOP_VERSION=$HADOOP_VERSION \
    --build-arg SCALA_VERSION=$SCALA_VERSION \
    --build-arg SBT_VERSION=$SBT_VERSION . \
    | while read line; do echo "$((`date +%s` - $start_time)) $line"; done \
     > build.out 2>&1 | tee build.out &

cat build.out
# (timeout 5 cat build.out || : ) | tail
