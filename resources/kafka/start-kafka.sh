#!/usr/bin/env bash

source /etc/profile.d/kafka.sh
EXEC_PATH=${KAFKA_HOME}/bin
ZOOKEEPER_EXEC_PATH=${EXEC_PATH}/zookeeper-server-start.sh
KAFKA_EXEC_PATH=${EXEC_PATH}/kafka-server-start.sh

nohup $ZOOKEEPER_EXEC_PATH $KAFKA_CONF/zookeeper.properties > $ZK_LOG_FILE 2>&1 < /dev/null & "'echo $! '"> $ZK_PID_FILE

nohup $KAFKA_EXEC_PATH $KAFKA_CONF/server.properties > $KAFKA_LOG_FILE 2>&1 < /dev/null & "'echo $! '"> $KAFKA_PID_FILE
