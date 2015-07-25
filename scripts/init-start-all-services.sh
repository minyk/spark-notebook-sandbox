#!/bin/bash
source "/vagrant/scripts/common.sh"

function formatNameNode {
	$HADOOP_PREFIX/bin/hdfs namenode -format myhadoop -force -noninteractive
	echo "formatted namenode"
}

function startHDFS {
	$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode
	$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode
	echo "started hdfs"
}

function startYarn {
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager
	$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
	$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
	echo "started yarn"
}

function createEventLogDir {
	$HADOOP_PREFIX/bin/hdfs dfs -mkdir /tmp
	$HADOOP_PREFIX/bin/hdfs dfs -mkdir /tmp/spark-events
	echo "created spark event log dir"
}

function startSpark {
	$SPARK_HOME/sbin/start-all.sh
	$SPARK_HOME/sbin/start-history-server.sh
	echo "started spark"
}

function startSparknotebook {
    $SPARKNOTEBOOK_HOME/start-spark-notebook.sh
    echo "started spark-notebook"
}

function setupServices {
    cp -f /vagrant/scripts/start-all-services.sh /etc/init.d/start-all-services
    chmod a+x /etc/init.d/start-all-services
    chkconfig start-all-services on
}

formatNameNode
startHDFS
#startYarn
createEventLogDir
startSpark
startSparknotebook
setupServices