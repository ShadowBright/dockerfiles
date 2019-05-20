#!/bin/bash

# env.sh initializes: JAVA_HOME, SPARK_HOME, HADOOP_HOME, generated from Dockerfile.
source env.sh

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"

# Add spark and hadoop paths for executables
export PATH=${PATH}:${HADOOP_HOME}/bin/:${HADOOP_HOME}/sbin/:${SPARK_HOME}/bin/:${SPARK_HOME}/sbin/:${JAVA_HOME}/bin

# From https://spark.apache.org/docs/latest/hadoop-provided.html
export SPARK_DIST_CLASSPATH=$(hadoop classpath)

# Use hadoop native libraries
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HADOOP_HOME}/lib/native/

# Keep spark master and slaves in foreground
export SPARK_NO_DAEMONIZE=1

# Required for YARN mode
export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop/

# Set Python path, without a fixed predefined py4j version
export PYTHONPATH=${PYTHONPATH}:/shared:${SPARK_HOME}/python:$(realpath ${SPARK_HOME}/python/lib/py4j-*-src.zip)

