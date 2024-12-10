## Overview

Deployments for my self-hosted kubernetes cluster

## Bootstrapping

### Flux

#### Install Flux

```sh
kubectl apply --server-side --kustomize ./bootstrap
```

### Apply Cluster Configuration

```sh
kubectl apply -f ./deploy/components/flux/flux.gen.yaml
```
