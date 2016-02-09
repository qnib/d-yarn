FROM qnib/d-java7

ADD etc/apt/sources.list.d/cloudera.list /etc/apt/sources.list.d/
RUN curl -s archive.key http://archive.cloudera.com/cdh5/debian/wheezy/amd64/cdh/archive.key | apt-key add - && \
    apt-get update && \
    apt-get install -y hadoop-yarn-resourcemanager \
                       hadoop-yarn-nodemanager

#### History
RUN echo "" >> /root/.bash_history && \
    echo "" >> /root/.bash_history

ENV HADOOP_HDFS_NAMENODE_PORT=8020 

## YARN
ADD etc/supervisord.d/yarn-nodemanager.ini \
	etc/supervisord.d/yarn-resourcemanager.ini \
    /etc/supervisord.d/
ADD opt/qnib/yarn/nodemanager/bin/start.sh /opt/qnib/yarn/nodemanager/bin/
ADD opt/qnib/yarn/resourcemanager/bin/start.sh /opt/qnib/yarn/resourcemanager/bin/
ADD etc/consul-templates/yarn/yarn-site.xml-INIT.ctmpl /etc/consul-templates/yarn/
