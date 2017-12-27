. 00-env.sh && kops rolling-update cluster \
    --name $KOPS_CLUSTER_NAME \
    --state $KOPS_STATE_STORE \
    --fail-on-validate-error="false" \
    --master-interval=8m \
    --node-interval=8m \
    --yes
