# k8s-log-forwarder
Kubernetes Log Forwarder Docker Image

This docker image provides the mechanism to forward logs from Kubernetes into logstash utilizing filebeat, kubetail and kubectl.
Dockerhub location: <https://hub.docker.com/r/seans/k8s-log-forwarder>

## Kubetail
The 'kubetail' script is the mechanism that does the log scraping from the kubernetes pods.
All the credit for kubetail belongs to johanheleby and the repo is located at: <https://github.com/johanhaleby/kubetail>

## Usage
1. A kubernetes deployment referring to the k8-log-forwarder docker image needs to be created and deployed into the namespace that contains the pods you wish to extract the logs for.
2. Set environment variables. There are 3 environment variables that k8-log-forwarder utilizes.
  * KUBE\_TAIL\_OPTIONS: see [here](https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail).
One additional option has been added: 'no-line-prefix' (if included, then the pod/container name is not part of the log output)
  * LOGSTASH_ENDPOINT: the logstash endpoint that filebeat sends logs to
  * FILTER (optional): if included, uses the value as grep input in order to filter what gets logged

## Requirements
- docker
- kubernetes cluster

## Build Command
```sh
$> docker build -t k8s-log-forwarder .
```