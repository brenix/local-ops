This component requires a secret to be created manually to provide additional
security.

1. Retrieve the `1password-credentials.json`
2. Create a secret like the following:

```
kubectl create secret generic --from-file 1password-credentials.json op-credentials
```
