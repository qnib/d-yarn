#!/usr/local/bin/dumb-init /bin/sh

source /opt/qnib/consul/etc/bash_functions.sh

if [ "${HADOOP_YARN_RESOURCEMANAGER}" != "true" ];then
    rm -f /etc/consul.d/yarn-resourcemanager.json
    consul reload
    sleep 2
    exit 0
fi

wait_for_srv hdfs-namenode
wait_for_srv hdfs-datanode

su -c '/usr/bin/yarn resourcemanager' hdfs
