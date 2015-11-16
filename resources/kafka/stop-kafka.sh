#!/usr/bin/env bash

source /etc/profile.d/kafka.sh

kill -TERM $KAFKA_PID_FILE
kill -TERM $ZK_PID_FILE