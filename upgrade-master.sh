#!/bin/bash

set -e

## apt-cache madison kubeadm

### https://kubernetes.io/zh/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

VERSION=1.19.4

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

sudo apt-mark unhold kubeadm && \
sudo apt-get update && apt-get install -y kubeadm=${VERSION}-00  && \
sudo apt-mark hold kubeadm 

kubeadm version

### sudo kubectl drain kmaster --ignore-daemonsets --delete-local-data

kubeadm upgrade plan

### kubeadm upgrade plan --config /etc/kubernetes/kubeadm.yaml

sudo kubeadm upgrade apply v${VERSION} -y


sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet=${VERSION}-00 kubectl=${VERSION}-00 && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload && sudo systemctl restart kubelet

## sudo kubectl uncordon master

kubectl version 

kubectl get node 
