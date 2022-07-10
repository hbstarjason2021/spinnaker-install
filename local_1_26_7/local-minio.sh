#!/bin/bash

set -euo pipefail

### MINIO_ROOT_USER=$(< /dev/urandom tr -dc a-z | head -c${1:-4})
### MINIO_ROOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8})

MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin
MINIO_ENCRYPTION_KEY=minio-encryption-key
LOCAL_IP=$(ifconfig eth0 |grep "inet "| awk '{print $2}')

NAME=minio
if [ -z "$(sudo docker ps -f name=${NAME} | grep ${NAME})" ]; then
  echo -e "\033[32m Running a new minio container \033[0m"
  ## echo "Running a new minio container"
  sudo docker run -p 9000:9000 -p 9090:9090 \
    --name ${NAME} \
    -d \
    -e "MINIO_ROOT_USER_FILE=${MINIO_ROOT_USER}" \
    -e "MINIO_ROOT_PASSWORD_FILE=${MINIO_ROOT_PASSWORD}" \
    -e "MINIO_KMS_SECRET_KEY_FILE=minio-encryption-key:${MINIO_ENCRYPTION_KEY}" \
    -v $HOME/minio/disk1:/disk1 \
    -v $HOME/minio/disk2:/disk2 \
    -v $HOME/minio/disk3:/disk3 \
    -v $HOME/minio/disk4:/disk4 \
    minio/minio server /disk{1...4} --console-address ":9090" -address ":9000"

else
  echo -e "\033[32m Starting minio container \033[0m"
  ## echo "Starting minio container"
  sudo docker start ${NAME}
fi

echo "$LOCAL_IP"

docker ps |grep "minio"
