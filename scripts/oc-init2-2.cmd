
:: Login to the docker registry and push latest images
oc whoami -t | docker login -u developer --password-stdin docker-registry-default.10.0.75.2.nip.io
