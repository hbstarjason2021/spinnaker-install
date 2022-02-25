#!/bin/bash

set -e

SPINNAKER_VERSION=1.25.7

sudo hal config version edit --version ${SPINNAKER_VERSION}

hal config provider kubernetes enable
hal config provider kubernetes account add my-k8s \
    --provider-version v2 \
    --context $(kubectl config current-context)
        
hal config deploy edit --type=distributed --account-name my-k8s

chmod 777 ~/.kube && chmod 777  ~/.kube/config

hal deploy apply
