#!/usr/bin/env bash

nohup /usr/local/spark-notebook/bin/spark-notebook -Dconfig.file=/usr/local/spark-notebook/conf/application.conf -Dhttp.port=8989 > /usr/local/spark-notebook/sparknotebook.log &