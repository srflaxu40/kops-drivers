export AWS_ACCESS_KEY_ID=""

export AWS_SECRET_ACCESS_KEY=""

export SPOTINST_TOKEN=""

export SPOTINST_ACCOUNT=""

export SPOTINST_CLOUD_PROVIDER="aws"

export KOPS_FEATURE_FLAGS="+SpotinstCloudProvider"

export KOPS_CLOUD_PROVIDER="spotinst"

export KOPS_STATE_STORE="s3://"

export KOPS_CLUSTER_NAME="example.k8s.com"

export KOPS_CLUSTER_ZONES="us-east-2a,us-east-2b,us-east-2c"

export NODEUP_URL="http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/nodeup/linux/amd64/nodeup"

export PROTOKUBE_IMAGE="http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/protokube/images/protokube.tar.gz"

export MASTER_SECURITY_GROUPS=""

export NODE_SECURITY_GROUPS=""

export KOPS_MASTER_SIZE="t2.large"

export KOPS_MASTER_COUNT="3"

export KOPS_NODE_SIZE="m4.large,c4.large,r3.large"

export KOPS_NODE_COUNT="2"

export VPC_ID=""

export NETWORK_CIDR="10.1.0.0/16"
