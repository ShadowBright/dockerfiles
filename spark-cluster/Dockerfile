FROM ubuntu:18.04

USER root

ARG SPARK_VERSION
ARG HADOOP_VERSION

ENV SPARK_VERSION=${SPARK_VERSION}
ENV HADOOP_VERSION=${HADOOP_VERSION}
ENV JDK_VERSION=8
ENV JAVA_HOME /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64/
ENV SPARK_HOME /opt/spark/
ENV HADOOP_HOME /opt/hadoop/
ENV HADOOP_CONF_DIR ${HADOOP_HOME}etc/hadoop/
ENV SPARK_ARCHIVE spark-${SPARK_VERSION}-bin-without-hadoop.tgz
ENV HADOOP_ARCHIVE hadoop-${HADOOP_VERSION}.tar.gz

# Setup SSH access
COPY config/id_rsa.pub /root/.ssh/authorized_keys
COPY config/id_rsa /root/.ssh/id_rsa


RUN apt-get -q update && \
    apt-get -q -fy install --no-install-recommends \ 
    python3-dev \
    python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    wget \
    vim \
    ssh \
    curl \
    openssh-server \
    openjdk-${JDK_VERSION}-jdk-headless && \
    pip3 install --upgrade pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 && \
    mkdir -p /tmp/config && \
    echo export JAVA_HOME=$JAVA_HOME > /tmp/config/env.sh && \
    echo export SPARK_HOME=$SPARK_HOME >> /tmp/config/env.sh && \
    echo export HADOOP_HOME=$HADOOP_HOME >> /tmp/config/env.sh && \
    echo export HADOOP_CONF_DIR=$HADOOP_CONF_DIR >> /tmp/config/env.sh && \
    echo source /tmp/config/init_env.sh >> ~/.bashrc && \
    echo ". '/opt/spark/sbin/spark-config.sh'" >> ~/.bashrc && \
    echo ". '/opt/spark/bin/load-spark-env.sh'" >> ~/.bashrc && \
    passwd -d root && \
    chmod 0600 /root/.ssh/id_rsa /root/.ssh/authorized_keys && \
    mkdir -p /opt/hadoop && \
    wget -nc -q http://apache.lauf-forum.at/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE} && \
    tar xzf ${HADOOP_ARCHIVE} --strip=1 -C /opt/hadoop && \
    rm ${HADOOP_ARCHIVE} && \
    mkdir -p /opt/spark && \
    wget -nc -q http://mirror.synyx.de/apache/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE} && \
    tar xzf ${SPARK_ARCHIVE} --strip=1 -C /opt/spark && \
    rm ${SPARK_ARCHIVE}


COPY config/hadoop/* ${HADOOP_HOME}/etc/hadoop/
COPY config/spark/* ${SPARK_HOME}/conf/

RUN cat ${HADOOP_HOME}/etc/hadoop/hadoop-env-init.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh >/tmp/hadoop-env.sh && \
    mv /tmp/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    rm ${HADOOP_HOME}/etc/hadoop/hadoop-env-init.sh && \
    chmod +x ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

COPY config/requirements.txt /tmp/config/requirements.txt
WORKDIR /tmp/config/
RUN chmod -R 755 /tmp/config/ && \
    pip install -r /tmp/config/requirements.txt

COPY config/init_env.sh \
     config/jupyter_notebook_config.py \
     config/entrypoint_master.sh \
     config/entrypoint_worker.sh \
     config/nbextentions.sh \
     config/test_spark.sh \
     config/test_hdfs.sh /tmp/config/


