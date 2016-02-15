#!/bin/bash

#java
JAVA_VERSION="7"
JAVA_UPDATE="79"
JAVA_ARCHIVE=jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
JAVA_HOME="jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}"

#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=2.7.1
HADOOP_ARCHIVE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE}
HADOOP_RES_DIR=/vagrant/resources/hadoop
HDFS_USER="hdfs"

#spark
SPARK_VERSION=1.5.2
SPARK_ARCHIVE=spark-${SPARK_VERSION}-bin-hadoop2.6.tgz
SPARK_MIRROR_DOWNLOAD=http://www.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE}
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf
SPARK_USER="spark"

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

#Kafka
KAFKA_VERSION=0.8.2.2
KAFKA_NAME=kafka_2.10-${KAFKA_VERSION}
KAFKA_ARCHIVE=${KAFKA_NAME}.tgz
KAFKA_MIRROR_DOWNLOAD=http://www.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_ARCHIVE}
KAFKA_RES_DIR=/vagrant/resources/kafka
KAFKA_HOME=/usr/local/kafka
KAFKA_CONF=${KAFKA_HOME}/conf
KAFKA_USER="kafka"

#Cassandra
CASSANDRA_VERSION=2.1.10
CASSANDRA_NAME=apache-cassandra-${CASSANDRA_VERSION}-bin
CASSANDRA_ARCHIVE=${CASSANDRA_NAME}.tar.gz
CASSANDRA_MIRROT_DOWNLOAD=http://www.apache.org/dist/cassandra/${CASSANDRA_VERSION}/${CASSANDRA_ARCHIVE}
CASSANDRA_RES_DIR=/vagrant/resources/cassandra
CASSANDRA_HOME=/usr/local/cassandra
CASSANDRA_CONF=${CASSANDRA_HOME}/conf

#spark-notebook
SPARKNOTEBOOK_VERSION=0.6.2
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
