FROM debian:jessie

ENV KUBE_LATEST_VERSION="v1.10.2" \
    FILEBEAT_VERSION=6.2.4
    
RUN set -x && \
    apt-get update && \
    apt-get install -y curl && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
	apt-get install -y curl && \
	curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-amd64.deb && \
	dpkg -i filebeat-${FILEBEAT_VERSION}-amd64.deb && \
	rm -f filebeat-${FILEBEAT_VERSION}-amd64.deb && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY kubetail docker-entrypoint.sh /
COPY filebeat.yml /etc/filebeat/filebeat-kubetail.yml

ENTRYPOINT ["/docker-entrypoint.sh"]
