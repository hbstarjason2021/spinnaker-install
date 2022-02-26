#!/bin/bash

set -e

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm=1.19.4-00 && \
sudo apt-mark hold kubeadm

sudo kubeadm upgrade node

sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet=1.19.4-00 kubectl=1.19.4-00 && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload && sudo systemctl restart kubelet
