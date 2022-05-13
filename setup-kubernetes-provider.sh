#!/bin/bash

set -e

## hal version list

SPINNAKER_VERSION=1.26.7
ACCOUNT_NAME=my-k8s

## hal version bom ${SPINNAKER_VERSION} -q -o yaml 

if [ -z "${SPINNAKER_VERSION}" ] ; then
  echo "SPINNAKER_VERSION not set"
  exit
fi

hal config version edit --version ${SPINNAKER_VERSION}
hal config provider kubernetes enable

if [ -z "$(hal config provider kubernetes account list | grep ${ACCOUNT_NAME})" ]; then
   CONTEXT=$(kubectl config current-context)
   echo -e "\033[32m Add kubernetes account ${ACCOUNT_NAME} with context ${CONTEXT} \033[0m"
   ## echo "====== Add kubernetes account ${ACCOUNT_NAME} with context ${CONTEXT}"
   hal config provider kubernetes account add ${ACCOUNT_NAME} \
      --provider-version v2 \
      --context ${CONTEXT}
else
  echo -e "\033[31m kubernetes account ${ACCOUNT_NAME} exists \033[0m"
  ## echo "====== kubernetes account ${ACCOUNT_NAME} exists"
fi
     
hal config deploy edit --type=distributed --account-name ${ACCOUNT_NAME}

## https://spinnaker.io/docs/setup/install/environment/
## hal config deploy edit --liveness-probe-enabled true --liveness-probe-initial-delay-seconds $LONGEST_SERVICE_STARTUP_TIME

chmod 777 -R /root/
#sudo chmod 777 /root/.kube && chmod 777 /root/.kube/config

#mkdir -p /home/zhang/.kube
#cp -i /root/.kube/config /home/zhang/.kube/config

### hal deploy apply

