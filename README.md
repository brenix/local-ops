## Overview

Deployments for my self-hosted kubernetes cluster

## Bootstrapping

### Flux

#### Install Flux

```sh
kubectl apply --server-side --kustomize ./bootstrap
```

#### Kick off Flux applying this repository

```sh
kubectl apply --server-side --kustomize ./clusters/main/flux
```
