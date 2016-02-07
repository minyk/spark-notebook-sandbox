#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalHadoop {
	echo "install hadoop from local file"
	FILE=/vagrant/resources/${HADOOP_ARCHIVE}
	tar -xzf $FILE -C /usr/local
}

function installRemoteHadoop {
	echo "install hadoop from remote file"
	curl -o /vagrant/resources/${HADOOP_ARCHIVE} -O -L ${HADOOP_MIRROR_DOWNLOAD}
	tar -xzf /vagrant/resources/${HADOOP_ARCHIVE} -C /usr/local
}

function setupUser {
    echo "creating hdfs user"
    getent group $HDFS_USER >/dev/null || groupadd -r $HDFS_USER
    getent passwd $HDFS_USER >/dev/null || useradd -c "HDFS" -g $HDFS_USER $HDFS_USER 2> /dev/null || :
}

function setupDirOwner {
    echo "chown of hadoop dirs."
    chown -R $HDFS_USER:$HDFS_USER /var/hadoop
}

function setupHadoop {
	echo "creating hadoop directories"
	mkdir /var/hadoop
	mkdir /var/hadoop/hadoop-datanode
	mkdir /var/hadoop/hadoop-namenode
	mkdir /var/hadoop/mr-history
	mkdir /var/hadoop/mr-history/done
	mkdir /var/hadoop/mr-history/tmp

	echo "copying over hadoop configuration files"
	cp -f ${HADOOP_RES_DIR}/* ${HADOOP_CONF_DIR}
}

function setupEnvVars {
	echo "creating hadoop environment variables"
	cp -f ${HADOOP_RES_DIR}/hadoop.sh /etc/profile.d/hadoop.sh
}

function installHadoop {
	if resourceExists ${HADOOP_ARCHIVE}; then
		installLocalHadoop
	else
		installRemoteHadoop
	fi
        chown -R $HDFS_USER:root /usr/local/hadoop-${HADOOP_VERSION}
	ln -s /usr/local/hadoop-${HADOOP_VERSION} /usr/local/hadoop
}


echo "setup hadoop"
setupUser
installHadoop
setupHadoop
setupEnvVars
setupDirOwner