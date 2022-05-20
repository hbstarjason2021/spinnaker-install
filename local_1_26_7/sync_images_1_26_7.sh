#!/bin/bash
set -x
S_REGISTRY="us-docker.pkg.dev/spinnaker-community"
T_REGISTRY="hbstarjason"

cat images_list_1_26_7.yaml  | while read line
do 
    echo ${line}
    docker pull ${S_REGISTRY}/docker/${line}
    docker tag ${S_REGISTRY}/docker/${line} ${T_REGISTRY}/${line}
    docker push ${T_REGISTRY}/${line}
    
    # docker pull ${T_REGISTRY}/${line}
    # docker tag ${T_REGISTRY}/${line} ${S_REGISTRY}/docker/${line}
    docker images |grep ${S_REGISTRY}
done 

##################################################
<<'COMMENT'

COMMENT
