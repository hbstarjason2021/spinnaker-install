#!/bin/bash

set -euo pipefail

red="\033[31m"
green="\033[32m"
yellow="\033[33m"
white="\033[0m"


USER=zhang

if (command -v hal >/dev/null 2>&1) then
  echo -e "$red hal exists, skipping $white"
  ## echo -e "\033[31m hal exists, skipping \033[0m"
  ## echo "=== hal exists, skipping"
else
  echo -e "$green hal doesn't exist, installing $white"
  ## echo -e "\033[32m hal doesn't exist, installing \033[0m"
  ## echo "=== hal doesn't exist, installing"
  sudo apt install -y default-jre
  curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
  sudo useradd -m zhang
  sudo bash InstallHalyard.sh --user ${USER} -y
  echo -e "$yellow hal version: $(hal -v) $white"
  ## echo -e "\033[32m hal version: $(hal -v) \033[0m"
  ## echo "hal version: $(hal -v)"
fi

##################################################
<<'COMMENT'
### https://spinnaker.io/docs/setup/install/halyard/

mkdir ~/.hal
docker run -p 8084:8084 -p 9000:9000 \
    --name halyard --rm \
    -v ~/.hal:/home/spinnaker/.hal \
    -itd \
    us-docker.pkg.dev/spinnaker-community/docker/halyard:stable
    ## hbstarjason/halyard:1.44.1

COMMENT
