# gobot-infra

Deploy all infrastructure

```bash
export TF_VAR_github_token=<secret>

tf plan -var-file=vars.tfvars
tf apply -var-file=vars.tfvars
tf destroy -var-file=vars.tfvars
```

Use generated kubeconfig file and verify created cluster

```bash
export KUBECONFIG=~/dev/gobot-infra/.terraform/modules/gke_cluster/kubeconfig
kubectl config view
```

Creare `gobot` namespace manifest
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: gobot
```

Create manifests for `gobot` repo helm changes tracking

```bash 
flux create source git gobot \
--url=https://github.com/ihorhrysha/gobot \
--branch=develop \
--namespace=gobot \
--export
```

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: gobot
  namespace: gobot
spec:
  interval: 1m0s
  ref:
    branch: develop
  url: https://github.com/ihorhrysha/gobot
```

```bash
flux create helmrelease gobot \
--namespace=gobot \
--source=GitRepository/gobot \
--chart="./helm" \
--interval=1m \
--export
```

Change HelmRelease apiVersion to `helm.toolkit.fluxcd.io/v2beta1` since `v2` in not installed by bootstrap

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: gobot
  namespace: gobot
spec:
  chart:
    spec:
      chart: ./helm
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: GitRepository
        name: gobot
  interval: 1m0s
```

and push changes to gitops repo

Check helm release
```bash
helm list -n gobot
```

New version in deployed
```
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION   
gobot   gobot           1               2024-08-12 15:29:12.804767184 +0000 UTC deployed        gobot-0.2.2     v1.0.0-d6bcb60
```