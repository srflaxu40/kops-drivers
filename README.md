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

---

## Where next?

* Install Heapster, Grafana, and Influxdb.

---

## Repos:
* [SpotInst Kops Fork](https://github.com/spotinst/kubernetes-kops).
