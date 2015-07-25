#!/bin/bash

#java
JAVA_ARCHIVE=jdk-7u51-linux-x64.gz
#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=2.6.0
HADOOP_ARCHIVE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE}
HADOOP_RES_DIR=/vagrant/resources/hadoop

#spark
SPARK_VERSION=1.4.1
SPARK_ARCHIVE=spark-${SPARK_VERSION}-bin-hadoop2.6.tgz
SPARK_MIRROR_DOWNLOAD=http://www.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE}
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

#flume
FLUME_VERSION=1.5.2
FLUME_ARCHIVE=apache-flume-1.5.2-bin.tar.gz
FLUME_MIRROR_DOWNLOAD=http://www.apache.org/dist/flume/1.5.2/apache-flume-1.5.2-bin.tar.gz
FLUME_RES_DIR=/vagrant/resources/flume
FLUME_HOME=/usr/local/flume
FLUME_CONF=${FLUME_HOME}/conf

#spark-notebook
SPARKNOTEBOOK_VERSION=0.6.0
SCALA_VERSION=2.10.4
SPARKNOTEBOOK_NAME=spark-notebook-${SPARKNOTEBOOK_VERSION}-scala-${SCALA_VERSION}-spark-${SPARK_VERSION}-hadoop-${HADOOP_VERSION}-with-hive-with-parquet
SPARKNOTEBOOK_ARCHIVE=${SPARKNOTEBOOK_NAME}.tgz
SPARKNOTEBOOK_MIRROR_DOWNLOAD=https://s3.eu-central-1.amazonaws.com/spark-notebook/tgz/${SPARKNOTEBOOK_ARCHIVE}
SPARKNOTEBOOK_RES_DIR=/vagrant/resources/spark-notebook
SPARKNOTEBOOK_HOME=/usr/local/spark-notebook
SPARKNOTEBOOK_CONF=${SPARKNOTEBOOK_HOME}/conf


function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"