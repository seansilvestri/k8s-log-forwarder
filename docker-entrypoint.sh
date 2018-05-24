#!/bin/bash

sed -i "s/#LOGSTASH_ENDPOINT#/${LOGSTASH_ENDPOINT}/g" filebeat.yml

filebeat -e -c filebeat.yml &

if [[ ! -z "$FILTER" ]]; then
    ./kubetail $(echo \"$KUBE_TAIL_OPTIONS\" | tr -d '\"') | grep "$FILTER" >> /var/log/kubetail.log
else
    ./kubetail $(echo \"$KUBE_TAIL_OPTIONS\" | tr -d '\"') >> /var/log/kubetail.log
fi
