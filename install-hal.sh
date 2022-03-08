#!/bin/bash

set -euo pipefail

red="\033[31m"
green="\033[32m"
yellow="\033[33m"
white="\033[0m"


USER=zhang

if (command -v hal >/dev/null 2>&1) then
  echo -e "\033[31m hal exists, skipping \033[0m"
  ##echo "=== hal exists, skipping"
else
  echo -e "\033[32m hal doesn't exist, installing \033[0m"
  ## echo "=== hal doesn't exist, installing"
  sudo apt install -y default-jre
  curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
  sudo useradd -m zhang
  sudo bash InstallHalyard.sh --user ${USER} -y
  echo -e "\033[32m hal version: $(hal -v) \033[0m"
  ## echo "hal version: $(hal -v)"
fi
