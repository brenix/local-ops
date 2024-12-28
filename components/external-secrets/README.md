# external-secrets

The doppler token secret must be created manually

```sh
kubectl create secret -n security generic --from-literal=dopplerToken=$TOKEN
```
