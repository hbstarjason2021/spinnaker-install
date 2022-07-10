#!/bin/bash

set -euo pipefail

git clone https://github.com/hbstarjason2021/spinnaker-install
## https://gitee.com/starjason/spinnaker-install

cp spinnaker-install/local_1_26_7/boms_1_26_7.tar.gz /root/
tar zvxf boms_1_26_7.tar.gz

BOMS_DIR="/root/.hal/"
BOMS_FILR=".boms"
KUBE_DIR="/root/.kube/" 

[ -d ${BOMS_DIR} ] || mkdir ${BOMS_DIR}
    mv ${BOMS_FILR} ${BOMS_DIR}
    ls -a ${BOMS_DIR}
    chmod 777 -R ${BOMS_DIR}
    chmod 777 -R ${KUBE_DIR}

 docker run -d  \
    --name halyard   \
    -v ${BOMS_DIR}:/home/spinnaker/.hal \
    -v ${KUBE_DIR}:/home/spinnaker/.kube \
    -it hbstarjason/halyard:1.44.1
 
 ## us-docker.pkg.dev/spinnaker-community/docker/halyard:stable
 #-v ${BOMS_DIR}/halyard-local.yaml:/opt/halyard/config/halyard.yml 

docker cp .hal/.boms/halyard-local.yaml halyard:/opt/halyard/config/halyard.yml

docker exec -it  halyard bash 

VERSION="1.26.7"
ACCOUNT_NAME="my-k8s"

hal config version edit --version local:${VERSION} --no-validate
hal config edit --timezone Asia/Shanghai

########## hal config storage edit --type redis 
echo ${MINIO_ROOT_PASSWORD} | hal config storage s3 edit \
  --access-key-id ${MINIO_ROOT_USER} \
  --secret-access-key \
  --endpoint http://$LOCAL_IP:9000

DEPLOYMENT="default"
USER="spinnaker"
mkdir -p /home/${USER}/.hal/$DEPLOYMENT/profiles/
echo "spinnaker.s3.versioning: false" > /home/${USER}/.hal/$DEPLOYMENT/profiles/front50-local.yml

hal config storage edit --type s3


hal config provider kubernetes enable --no-validate
hal config provider kubernetes account add ${ACCOUNT_NAME} \
    --docker-registries dockerhub \
    --context $(kubectl config current-context) \
    --service-account true \
    --omit-namespaces=kube-system,kube-public \
    --provider-version v2 \
    --no-validate
    
hal config deploy edit \
    --account-name ${ACCOUNT_NAME} \
    --type distributed \
    --location spinnaker \
    --no-validate    
    
hal config features edit --pipeline-templates true  --no-validate
hal config features edit --artifacts true --no-validate
hal config features edit --managed-pipeline-templates-v2-ui true --no-validate


hal config provider kubernetes account list 

hal deploy apply --no-validate
