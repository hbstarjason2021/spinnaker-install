#!/bin/bash

set -euo pipefail

git clone https://github.com/hbstarjason2021/spinnaker-install
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
    #-v ${BOMS_DIR}/halyard-local.yaml:/opt/halyard/config/halyard.yml \
    -v ${KUBE_DIR}:/home/spinnaker/.kube \
    -it hbstarjason/halyard:1.44.1
    ## us-docker.pkg.dev/spinnaker-community/docker/halyard:stable
    
docker exec -it  halyard bash 

VERSION="1.26.7"
ACCOUNT_NAME="my-k8s"

hal config version edit --version local:${VERSION} --no-validate
hal config edit --timezone Asia/Shanghai
hal config storage edit --type redis 

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


hal config provider kubernetes enable --no-validate
hal config provider kubernetes account add my-k8s \
    --context $(kubectl config current-context) \
    --service-account true \
    --omit-namespaces=kube-system,kube-public \
    --provider-version v2 \
    --no-validate
    
hal config deploy edit \
    --account-name my-k8s \
    --type distributed \
    --location spinnaker \
    --no-validate    

hal config provider kubernetes account list 

hal deploy apply --no-validate