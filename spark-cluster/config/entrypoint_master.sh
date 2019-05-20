#!/bin/bash

# Initialize env variables
source /tmp/config/init_env.sh

sh /tmp/config/nbextentions.sh


# start SSH service
service ssh start

# To be executed at runtime (this requires sshd already running)
ssh-keyscan spark-master,localhost,0.0.0.0 > /root/.ssh/known_hosts

# format HDFS name node folder only if not existing (otherwise, reuse it!)
if [ ! -d /data/hdfs/nn ]; then
    hdfs namenode -format
    sleep 5
fi

start-dfs.sh
sleep 5

hdfs dfsadmin -safemode leave

if ! $(hdfs dfs -test -d /logs); then
    hdfs dfs -mkdir /logs
    hdfs dfs -chmod -R 1777 /logs
fi

### Start YARN
start-yarn.sh

if [[ ! -d /tmp/spark-events ]]; then
    mkdir -p /tmp/spark-events
fi

start-history-server.sh &

# Start Spark master node
start-master.sh &

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='lab --config=/tmp/config/jupyter_notebook_config.py'


RUN echo "export PYSPARK_DRIVER_PYTHON=${PYSPARK_DRIVER_PYTHON}" >> ~/.bashrc
RUN echo "export PYSPARK_DRIVER_PYTHON_OPTS='${PYSPARK_DRIVER_PYTHON_OPTS}'" >> ~/.bashrc
RUN echo "alias jel='jupyter nbextension list'" >> ~/.bashrc

pyspark

