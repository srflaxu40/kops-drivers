# production-kops

Setup *KOPS* on *AWS* with RBAC enabled and initial role bindings in private topology with calico networking.

## Setup:

* Download and install latest spotinst kops binary compiled just for SpotInst:
```
darwin_amd64
http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/bin/darwin/amd64/kops

linux_amd64
http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/bin/linux/amd64/kops
```

## Create Cluster && VPC:
* Scripts provided by [spotinst kops](http://blog.spotinst.com/2017/08/17/elastigroup-kubernetes-operations-kops/).

* Edit the values in `00-env.sh`

* `cd bin && ./01-create.sh`

* Wait about 5-10 minutes.

## Create in Existing VPC:
* Edit the values in `00-env.sh`

* `cd bin && ./02-create-wo-apply.sh`

* `. 00-env.sh && kops get clusters -o yaml > config.yaml `

* `. 00-env.sh && kops edit cluster`
  - Change your subnet CIDRs to non-conflicting CIDRs; IE those that aren't currently used in your VPC.
  - You could also manuall edit `vim config.yaml`.
    
* `kops replace -f config.yaml`

* `cd bin && ./07-update.sh`

## Update ig:
* `. 00-env.sh && kops edit ig <instance group>`
* `. 00-env.sh && kops update cluster --name $KOPS_CLUSTER_NAME`
* `. 00-env.sh && kops rolling-update --name $KOPS_CLUSTER_NAME --yes`

## Deploy Spaceship:

### Creating pull secret for dockerhub registry (only run once):
* Create DockerHub Image Pull Secrets (Jenkins username / password are available in _Jenkins_ or _1Password_):

`./bin/create_secret.sh <DockerHub user> <DockerHub pass> <DockerHub email>`

* Now patch the default service account to automagically add pull secret to all pods in the default namespace:

`kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registrykey"}]}'`

* Note that this also requires you add the appropriate collaborators under each DockerHub repo.

* If you have issues, see [here-image-pull-secrets](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/).

### HELM - Initializing helm after cluster boot:
* After deploying a new kubernetes cluster via kops (and configuring your env locally to interact with it properly),
  be sure to give helm permissions to act on namespaces with:

`kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default`

* `helm init` - you should get the message `HAPPY TILLING`, and you are now ready to rock 'n roll.

### Install Nginx Ingress:
* Follow the [Generic Deployment Instructions, and also use the `Install with RBAC roles`](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/README.md).
  - The above are installed under the `ingress-nginx` namespace.
  - For a good example of ingress with a service please look at `build-files/statengine`.

## Export your admin level config for use elsewhere:
* Set your KUBECONFIG environment variable so you don't overwrite or merge to a current config:
  - `export KUBECONFIG=$HOME/tools.prominentedge.com`

* Export:
  - `kops export kubecfg --name tools.prominentedge.com`

## Install External DNS:

* Update IAM roles by creating and attaching the IAM policy specified [here](https://github.com/kubernetes-incubator/external-dns/blob/master/docs/tutorials/aws.md).

```
cd ./external-dns
kubectl create -f external*
```

* Enjoy spaceship.


![Spaceship](http://www.likecool.com/Gear/Pic/Gif%20Star%20Trek%20Defiant%20USS%20NCC1764/Gif-Star-Trek-Defiant-USS-NCC1764.gif)


![Spaceship-Dance](https://upload-assets.vice.com/files/2015/12/16/1450302693Drake2.gif)

---

## Where next?

* Install Heapster, Grafana, and Influxdb.

---

## Repos:
* [SpotInst Kops Fork](https://github.com/spotinst/kubernetes-kops).
