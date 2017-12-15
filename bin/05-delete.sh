. 00-env.sh && kops delete cluster \
    --name $KOPS_CLUSTER_NAME \
    --state $KOPS_STATE_STORE \
    --yes
