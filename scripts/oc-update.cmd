:: This script will update openshifts internal docker registry with the latest images
::
:: It requires the services to be built in advance. Also you have to be logged into openshift in order to be able to push 
:: the images.

docker build -t xmas:latest ..\elf
docker tag xmas:latest docker-registry-default.10.0.75.2.nip.io/xmas/elf:latest
docker push docker-registry-default.10.0.75.2.nip.io/xmas/elf