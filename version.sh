#!/bin/bash

set -euo pipefail

until hal --ready; do sleep 10 ; done

hal-v

hal version list

SPINNAKER_VERSION=1.26.7
hal version bom ${SPINNAKER_VERSION} -q -o yaml >/tmp/${SPINNAKER_VERSION}.yml
