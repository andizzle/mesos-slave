#!/bin/bash

set -e

HOSTNAME=`hostname`
IPADDRESS=`/sbin/ip route|awk '/eth1/ { print $9 }'`

ZK_SERVERS=($(/opt/zookeeper/bin/zkCli.sh -server $IPADDRESS:2181 get /zookeeper/config | grep ^server | awk -F':' '{print $1}' | awk -F'=' '{print $2}'))

ZK_COUNT=${#ZK_SERVERS[@]}

ZK_SERVERS=$(printf "%s:2181," "${ZK_SERVERS[@]}")
ZK_SERVERS=${ZK_SERVERS::-1}

ZK_LINK=zk://$ZK_SERVERS/mesos

if ! [ -n "$1" ]; then
    MESOS_HOSTNAME=$HOSTNAME MESOS_IP=$IPADDRESS MESOS_MASTER=$ZK_LINK mesos-slave
fi

exec "$@"
