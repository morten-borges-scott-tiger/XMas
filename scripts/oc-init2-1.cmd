:: This script will start the OpenShift cluster and deploy a DRO-frontend, backend and PostgreSQL database server.
::
:: It requires that Docker is installed and setup with an exposed TLS Docker deamon (without TLS) and 
:: the Openshift Docker registry registered as an insecure registry in the deamon.
::
:: It also assumes that you have two Docker images created (and tagged):
:: - One image for the backend (docker-registry-default.10.0.75.2.nip.io/dro/case-service:latest)
:: - and one image for the frontend (docker-registry-default.10.0.75.2.nip.io/dro/dro-portal:latest)
::
:: The entire cluster and it's configuration can be terminated using:
:: > oc cluster down


:: Start the OpenShift cluster
oc cluster up


:: Give developer cluster-admin rights
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer


:: Create secure route to the docker repo within the cluster (in the default deployment)
oc login -u developer
oc project default
oc create route edge --service=docker-registry


:: Create the project (dro)
:: TODO: The display name contains a weird character instead if the 'ø'
oc new-project dro --display-name="Digital Revisoropgørelse"


:: Create the image streams
oc create is case-service -n dro
oc create is dro-portal -n dro


:: Deploy a PostgreSQL database server
oc new-app -e POSTGRESQL_USER=dro -e POSTGRESQL_PASSWORD=dro -e POSTGRESQL_DATABASE=drodb centos/postgresql-96-centos7

