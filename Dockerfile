FROM debian:jessie

ENV KUBE_LATEST_VERSION="v1.10.2" \
    FILEBEAT_VERSION=5.6.9 \
    FILEBEAT_SHA1=591b54183057261a302f733d9c8d07debb85327a645e1044af44f5b547499e93a9f4f3912479217c59f3056f28f0110f8a2cca75be2f975cd26b3999ecb5329b
    
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