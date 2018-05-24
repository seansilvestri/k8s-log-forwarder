FROM debian:jessie

ENV KUBE_LATEST_VERSION="v1.10.2" \
    FILEBEAT_VERSION=6.2.4 \
    FILEBEAT_SHA1=19d0a93a42a758b8c9e71ca2691130fe5998fcb717019e29864f6ce0a21d4880c1654581220f0ce0f6118c914629df2baa91e95728f4e6a333666dffdf04df20
    
RUN set -x && \
    apt-get update && \
    apt-get install -y curl && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

RUN set -x && \
    apt-get update && \
    apt-get install -y wget && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
    cd /opt && \
    echo "${FILEBEAT_SHA1} filebeat.tar.gz" | sha512sum -c - && \
    tar xzvf filebeat.tar.gz && \
    cd filebeat-* && \
    cp filebeat /bin && \
    cd /opt && \
    rm -rf filebeat* && \
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY filebeat.yml kubetail docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
