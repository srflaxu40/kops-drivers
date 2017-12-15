. 00-env.sh && kops rolling-update cluster \
    --name $KOPS_CLUSTER_NAME \
    --state $KOPS_STATE_STORE \
    --yes
