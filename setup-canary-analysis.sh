#!/bin/bash

set -e

### https://spinnaker.io/docs/setup/other_config/canary/

PROMETHEUS_ACCOUNT="prometheus-account"
PROMETHEUS_URL="http://prometheus-prometheus.monitoring:9090"

hal config canary enable
hal config canary edit --show-all-configs-enabled false
hal config canary edit --default-metrics-store prometheus
hal config canary edit --default-metrics-account $PROMETHEUS_ACCOUNT

hal config canary prometheus enable
hal config canary prometheus account add $PROMETHEUS_ACCOUNT --base-url http://$PROMETHEUS_URL

hal config canary prometheus account list

hal config canary prometheus account get $PROMETHEUS_ACCOUNT
