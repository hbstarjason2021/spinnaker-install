#!/bin/bash

set -e

SPINNAKER_VERSION=1.25.7
ACCOUNT_NAME=my-k8s

hal config provider kubernetes enable

if [ -z "$(hal config provider kubernetes account list | grep ${ACCOUNT_NAME})" ]; then
   CONTEXT=$(kubectl config current-context)
   echo "=== Add kubernetes account ${ACCOUNT_NAME} with context ${CONTEXT}"
   hal config provider kubernetes account add ${ACCOUNT_NAME} \
      --provider-version v2 \
      --context ${CONTEXT}
else
  echo "=== kubernetes account ${ACCOUNT_NAME} exists"
fi

hal config version edit --version ${SPINNAKER_VERSION}
       
hal config deploy edit --type=distributed --account-name ${ACCOUNT_NAME}


sudo chmod 777 /root/.kube && chmod 777 /root/.kube/config

#mkdir -p /home/zhang/.kube
#cp -i /root/.kube/config /home/zhang/.kube/config

### hal deploy apply
