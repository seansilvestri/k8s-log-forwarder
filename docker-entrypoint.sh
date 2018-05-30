#!/bin/bash

sed -i "s/#LOGSTASH_URI#/${LOGSTASH_URI}/g" /etc/filebeat/filebeat-kubetail.yml

filebeat -e -c filebeat-kubetail.yml &

if [[ ! -z "$FILTER" ]]; then
    ./kubetail $(echo \"$KUBE_TAIL_OPTIONS\" | tr -d '\"') | grep "$FILTER" >> /var/log/kubetail.log
else
    ./kubetail $(echo \"$KUBE_TAIL_OPTIONS\" | tr -d '\"') >> /var/log/kubetail.log
fi
