#!/bin/bash

# $1 ig name

if [ ?# == 0 ]; then
  
  echo "Usage: `basename $0` <instance-group>"

fi

. 00-env.sh && kops create ig $1\
    --name $KOPS_CLUSTER_NAME \
    --role node \
    --subnet "us-east-1b.thinkgis.k8s.local"
