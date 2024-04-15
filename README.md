## Overview

Deployments for my self-hosted kubernetes cluster

## Bootstrapping

### Flux

#### Install Flux

```sh
kubectl apply --server-side --kustomize ./cluster/bootstrap
```

### Apply Cluster Configuration

_These cannot be applied with `kubectl` in the regular fashion due to some files
being encrypted with sops_

```sh
sops --decrypt ./cluster/bootstrap/age-key.sops.yaml | kubectl apply -f -
kubectl apply -f ./cluster/flux/vars/cluster-settings.yaml
```

### Kick off Flux applying this repository

```sh
kubectl apply --server-side --kustomize ./cluster/flux/config
```
