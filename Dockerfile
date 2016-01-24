FROM mesosphere/mesos-slave:0.26.0-0.2.145.ubuntu1404

RUN apt-get update \
&& apt-get install -y openjdk-7-jre-headless wget iproute2 \
&& apt-get clean

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz | tar -xzf - -C /opt \
&& mv /opt/zookeeper-3.5.1-alpha /opt/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ADD mesos-slave-init.sh /usr/local/bin/
ENTRYPOINT ["mesos-slave-init.sh"]
