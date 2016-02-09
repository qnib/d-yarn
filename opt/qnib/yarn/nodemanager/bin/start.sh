#!/usr/local/bin/dumb-init /bin/bash

source /etc/bashrc.hadoop
source /opt/qnib/consul/etc/bash_functions.sh

function stop_it {
    su -c '/opt/hadoop/sbin/yarn-daemon.sh stop nodemanager' hadoop
}

trap stop_it TERM EXIT

wait_for_srv yarn-resourcemanager

#consul-template -consul localhost:8500 -once -template "/etc/consul-templates/yarn/yarn-site.xml.ctmpl:/opt/qnib/yarn/nodemanager/etc/yarn-site.xml"
su -c '/usr/bin/yarn nodemanager' yarn
