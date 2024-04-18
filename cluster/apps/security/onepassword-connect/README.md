This component requires a secret to be created manually to provide additional
security.

1. Retrieve the `1password-credentials.json`
2. Create a secret like the following:

```
kubectl create secret generic --from-literal=1password-credentials.json=$(cat 1password-credentials.json | base64 -w0) op-credentials
```
