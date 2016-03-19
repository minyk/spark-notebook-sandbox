#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalKafka {
	echo "install spark from local file"
	FILE=/vagrant/resources/$KAFKA_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteKafka {
	echo "install spark from remote file"
	curl -o /vagrant/resources/$KAFKA_ARCHIVE -O -L $KAFKA_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$KAFKA_ARCHIVE -C /usr/local
}

function setupKafka {
	echo "setup kafka"
	cp -f /vagrant/resources/kafka/server.properties /usr/local/kafka/config
	cp -f /vagrant/resources/kafka/zookeeper.properties /usr/local/kafka/config
	cp -f /vagrant/resources/kafka/start-kafka.sh /usr/local/kafka
	cp -f /vagrant/resources/kafka/stop-kafka.sh /usr/local/kafka
	mkdir -p /usr/local/kafka/logs
}

function setupUser {
    echo "creating kafka user"
    getent group $KAFKA_USER >/dev/null || groupadd -r $KAFKA_USER
    getent passwd $KAFKA_USER >/dev/null || useradd -c "KAFKA" -g $KAFKA_USER $KAFKA_USER 2> /dev/null || :
}

function setupEnvVars {
	echo "creating kafka environment variables"
	cp -f $KAFKA_RES_DIR/kafka.sh /etc/profile.d/kafka.sh
}

function installKafka {
	if resourceExists ${KAFKA_ARCHIVE}; then
		installLocalKafka
	else
		installRemoteKafka
	fi
	chown -R $KAFKA_USER:root /usr/local/${KAFKA_NAME}
	ln -s /usr/local/${KAFKA_NAME} $KAFKA_HOME
}

echo "setup kafka"

setupUser
installKafka
setupKafka
setupEnvVars