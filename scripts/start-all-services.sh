#!/bin/bash
#
#       /etc/rc.d/init.d/<servicename>
#
#       <description of the *service*>
#       <any general comments about this init script>
#
# <tags -- see below for tag definitions.  *Every line* from the top
#  of the file to the end of the tags section must begin with a #
#  character.  After the tags section, there should be a blank line.
#  This keeps normal comments in the rest of the file from being
#  mistaken for tags, should they happen to fit the pattern.>

# Source function library.
### BEGIN INIT INFO
# Provides: iptables
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop hadoop/spark
# Description: Start, stop hadoop/spark
### END INIT INFO

. /etc/init.d/functions

source /etc/profile.d/java.sh
source /etc/profile.d/hadoop.sh
source /etc/profile.d/spark.sh
source /etc/profile.d/spark-notebook.sh

start() {
	$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
	$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
	echo "started hdfs"
#	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
#	$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
#	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
#	$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
#	echo "started yarn"
	$SPARK_HOME/sbin/start-all.sh
	$SPARK_HOME/sbin/start-history-server.sh
	echo "started spark"
	$SPARKNOTEBOOK_HOME/start-spark-notebook.sh
	echo "started spark-notebook"
	return 0
}

stop() {
	$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode
	$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode
	echo "stopped hdfs"
#	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager
#	$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR stop nodemanager
#	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh stop proxyserver --config $HADOOP_CONF_DIR
#	$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh stop historyserver --config $HADOOP_CONF_DIR
#	echo "stopped yarn"
	$SPARK_HOME/sbin/stop-all.sh
	$SPARK_HOME/sbin/stop-history-server.sh
	echo "stopped spark"
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