#!/bin/bash

set -e

SPINNAKER_VERSION=1.25.7

sudo hal config version edit --version ${SPINNAKER_VERSION}

sudo hal config provider kubernetes enable
sudo hal config provider kubernetes account add my-k8s \
    --provider-version v2 \
    --context $(kubectl config current-context)
        
sudo hal config deploy edit --type=distributed --account-name my-k8s

sudo chmod 777 ~/.kube && chmod 777  ~/.kube/config

mkdir -p /home/zhang/.kube
sudo cp -i /root/.kube/config /home/zhang/.kube/config

sudo hal deploy apply
