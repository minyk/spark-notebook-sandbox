#!/bin/bash
#
# Starts a Spark-Notebook Server
#
# chkconfig: 345 90 10
# description: hdfs,spark,spark-notebook
#
### BEGIN INIT INFO
# Provides: start-all-services
# Required-Start:
# Required-Stop:
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Short-Description: start and stop hadoop/spark
# Description: Start, stop hadoop/spark
### END INIT INFO

# Source function library.
. /etc/init.d/functions

source /etc/profile.d/java.sh
source /etc/profile.d/hadoop.sh
source /etc/profile.d/spark.sh
source /etc/profile.d/kafka.sh
source /etc/profile.d/spark-notebook.sh

function start_hdfs() {
	su -s /bin/bash $HDFS_USER -c "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode"
	su -s /bin/bash $HDFS_USER -c "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode"
	echo "started hdfs"
}

function stop_hdfs() {
	su -s /bin/bash $HDFS_USER -c "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode"
	su -s /bin/bash $HDFS_USER -c "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode"
	echo "stopped hdfs"
}

function start_yarn() {
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
	$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
	echo "started yarn"
}

function stop_yarn() {
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR stop nodemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh stop proxyserver --config $HADOOP_CONF_DIR
	$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh stop historyserver --config $HADOOP_CONF_DIR
	echo "stopped yarn"
}

function start_spark() {
    su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/start-master.sh"
	su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/start-slave.sh spark://spark-notebook1.example.com:7077"
	su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/start-history-server.sh"
	echo "started spark"
}

function stop_spark() {
    su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/stop-master.sh"
	su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/stop-slave.sh"
	su -s /bin/bash $SPARK_USER -c "$SPARK_HOME/sbin/stop-history-server.sh"
	echo "stopped spark"
}

function start_sparknotebook() {
	$SPARKNOTEBOOK_HOME/start-spark-notebook.sh
	echo "started spark-notebook"
}

function stop_sparknotebook() {
    killproc -pidfile /usr/local/spark-notebook/RUNNING_PID java
    echo "stopped spark-notebook"
}

function start_kafka {
    $KAFKA_HOME/start-kafka.sh
    echo "started kafka"
}

function stop_kafka {
    $KAFKA_HOME/stop-kafka.sh
    echo "stopped kafka"
}

start() {
    start_hdfs
    #start_yarn
    start_spark
    start_sparknotebook
    start_kafka
	return 0
}

stop() {
    stop_kafka
    stop_sparknotebook
    stop_spark
    #stop_yarn
    stop_hdfs
	return 0
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: start-all-services {start|stop}"
        exit 1
        ;;
esac
exit $?