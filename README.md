## Overview

Configuration for my self-hosted kubernetes cluster, managed using
[holos](https://holos.run) and [talos](https://talos.dev)

## Bootstrapping

### Flux

#### Install Flux

```sh
kubectl apply --server-side --kustomize ./bootstrap
```

#### Create doppler secret

See [external-secrets README](/components/external-secrets/README.md)

### Apply Cluster Configuration

```sh
kubectl apply -f ./deploy/components/flux/flux.gen.yaml
```
