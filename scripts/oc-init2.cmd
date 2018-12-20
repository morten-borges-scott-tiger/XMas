
:: Login to the docker registry and push latest images
oc whoami -t | docker login -u developer --password-stdin docker-registry-default.10.0.75.2.nip.io
docker push docker-registry-default.10.0.75.2.nip.io/xmas/elf


:: Deploy backend (case-service) from the appropriate image stream (once the Docker images has been pushed to it)
oc new-app --image-stream=elf --name=elf
oc expose svc/elf