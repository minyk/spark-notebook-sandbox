#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalSparkNotebook {
	echo "install spark-notebook from local file"
	FILE=/vagrant/resources/$SPARKNOTEBOOK_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteSparkNotebook {
	echo "install spark-notebook from remote file"
	curl -o /vagrant/resources/$SPARKNOTEBOOK_ARCHIVE -O -L $SPARKNOTEBOOK_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$SPARKNOTEBOOK_ARCHIVE -C /usr/local
}

function setupSparkNotebook {
	echo "setup spark-notebook"
	cp -f /vagrant/resources/spark-notebook/start-spark-notebook.sh /usr/local/spark-notebook
	cp -f /vagrant/resources/spark-notebook/clusters /usr/local/spark-notebook/conf/clusters
	cp -f /vagrant/resources/spark-notebook/profiles /usr/local/spark-notebook/conf/profiles
	cp -f /vagrant/resources/spark-notebook/application.conf /usr/local/spark-notebook/conf
}

function setupEnvVars {
	echo "creating spark-notebook environment variables"
	cp -f $SPARKNOTEBOOK_RES_DIR/spark-notebook.sh /etc/profile.d/spark-notebook.sh
}

function installSparkNotebook {
	if resourceExists ${SPARKNOTEBOOK_ARCHIVE}; then
		installLocalSparkNotebook
	else
		installRemoteSparkNotebook
	fi
	ln -s /usr/local/${SPARKNOTEBOOK_NAME} /usr/local/spark-notebook
}

echo "setup spark-notebook"

installSparkNotebook
setupSparkNotebook
setupEnvVars