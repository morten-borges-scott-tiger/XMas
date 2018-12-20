docker push docker-registry-default.10.0.75.2.nip.io/dro/case-service
docker push docker-registry-default.10.0.75.2.nip.io/dro/dro-portal


:: Deploy backend (case-service) from the appropriate image stream (once the Docker images has been pushed to it)
oc new-app --image-stream=case-service --name=case-service
oc expose svc/case-service


:: Deploy frontend (dro-portal) from the appropriate image stream (once the Docker images has been pushed to it)
oc new-app --image-stream=dro-portal --name=dro-portal
oc expose svc/dro-portal

