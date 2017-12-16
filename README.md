# production-kops

Setup KOPS with RBAC enabled and initial role bindings in private topology with calico networking.

## Setup:

* Download and install latest spotinst kops binary compiled just for SpotInst:
```
darwin_amd64
http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/bin/darwin/amd64/kops

linux_amd64
http://spotinst-public.s3.amazonaws.com/integrations/kubernetes/kops/v1.8.0-alpha.1/bin/linux/amd64/kops
```

## Create Cluster && VPC:
* Scripts provided by spotinst kops.

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

## HELM - Initializing helm after cluster boot:
* After deploying a new kubernetes cluster via kops (and configuring your env locally to interact with it properly),
  be sure to give helm permissions to act on namespaces with:

`kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default`

* `helm init` - you should get the message `HAPPY TILLING`, and you are now ready to rock 'n roll.

## Install Nginx Ingress:
* Follow the [Generic Deployment Instructions, and also use the `Install with RBAC roles`](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/README.md).
  - The above are installed under the `ingress-nginx` namespace.
  - For a good example of ingress with a service please look at `build-files/statengine`.

---

## Where next?

* Install Heapster, Grafana, and Influxdb.

---

## Repos:
* [SpotInst Kops Fork](https://github.com/spotinst/kubernetes-kops).
