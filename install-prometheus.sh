#!/bin/bash

set -e

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create ns monitoring
helm upgrade -i prometheus prometheus-community/kube-prometheus-stack \
--namespace monitoring \
--set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
--set fullnameOverride=prometheus

