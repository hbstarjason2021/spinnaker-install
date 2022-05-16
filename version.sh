#!/bin/bash

set -euo pipefail

until hal --ready; do sleep 10 ; done

hal-v

hal version list

## https://storage.googleapis.com/halconfig/bom/1.26.7.yml

## https://spinnaker.io/community/releases/versions/ 
SPINNAKER_VERSION=1.26.7
hal version bom ${SPINNAKER_VERSION} -q -o yaml >/tmp/${SPINNAKER_VERSION}.yml
