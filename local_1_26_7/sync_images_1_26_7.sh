#!/bin/bash
set -x
S_REGISTRY="us-docker.pkg.dev/spinnaker-community"
T_REGISTRY="hbstarjason"

cat images_list_1_26_7.yaml  | while read line
do 
    echo ${line}
    
    #docker pull ${S_REGISTRY}/docker/${line}
    #docker tag ${S_REGISTRY}/docker/${line} ${T_REGISTRY}/${line}
    #docker push ${T_REGISTRY}/${line}
    
    docker pull ${T_REGISTRY}/${line}
    docker tag ${T_REGISTRY}/${line} ${S_REGISTRY}/docker/${line}
    docker images |grep ${S_REGISTRY}
    docker images |grep ${T_REGISTRY}
done 

##################################################
<<'COMMENT'

images=(
  clouddriver:8.0.4-20210625060028
  deck:3.7.2-20210614020020
  echo:2.17.1-20210429125836
  fiat:1.16.0-20210422230020
  front50:0.27.1-20210625161956
  gate:1.22.2-20211214195244
  orca:2.20.3-20210630022216
  rosco:0.25.0-20210422230020
  monitoring-daemon:0.19.3-20210415230021
)

for imageName in ${images[@]};do
  docker pull ${T_REGISTRY}/$imageName
  docker tag  ${T_REGISTRY}/$imageName ${S_REGISTRY}/$imageName
  docker rmi  ${T_REGISTRY}/$imageName
done

COMMENT
