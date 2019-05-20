#!/bin/bash

# Initialize env variables
source /tmp/config/init_env.sh

# Start Spark slave node
start-slave.sh spark://spark-master:7077
