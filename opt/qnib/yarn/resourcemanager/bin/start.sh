#!/usr/local/bin/dumb-init /bin/bash

source /opt/qnib/consul/etc/bash_functions.sh

if [ "${HADOOP_YARN_RESOURCEMANAGER}" != "true" ];then
    rm -f /etc/consul.d/yarn-resourcemanager.json
    consul reload
    sleep 2
    exit 0
fi

wait_for_srv hdfs-namenode
wait_for_srv hdfs-datanode
if [ "${HADOOP_YARN_RESOURCEMANAGER}" == "true" ];then
    CTMPL=/etc/consul-templates/yarn/yarn-site.xml-INIT.ctmpl
else
    CTMPL=/etc/consul-templates/yarn/yarn-site.xml.ctmpl
fi

consul-template -consul localhost:8500 -once -template ${CTMPL}:/etc/hadoop/yarn-site.xml

su -c '/usr/bin/yarn resourcemanager' yarn
