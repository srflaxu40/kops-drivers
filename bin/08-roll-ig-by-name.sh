#!/bin/bash

if [ ?# == 0 ]; then
  
  echo "Usage: `basename $0` <instance-group-name>"

fi

. 00-env.sh && kops rolling-update cluster \
    --name $KOPS_CLUSTER_NAME \
    --state $KOPS_STATE_STORE \
    --fail-on-validate-error="false" \
    --master-interval=8m \
    --node-interval=8m \
    --instance-group $1 \
    --yes
