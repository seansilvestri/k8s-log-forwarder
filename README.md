# k8s-log-forwarder
Kubernetes Log Forwarder Docker Image

# Requirements
- docker

# Running stand-alone
```sh
$> docker build -t k8s-log-forwarder .
$> docker run -d -e KUBE_TAIL_OPTIONS=BAR -e FILTER=BAR k8s-log-forwarder
```
