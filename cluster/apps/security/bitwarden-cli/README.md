This component requires a secret to be created manually to provide additional
security.

1. Retrieve the bitwarden client id and client secret
2. Create a secret like the following:

```
apiVersion: v1
kind: Secret
metadata:
  name: bitwarden-cli
  namespace: security
type: Opaque
stringData:
  BW_PASSWORD: <MASTER PASSWORD>
  BW_CLIENTID: <BITWARDEN CLIENT ID>
  BW_CLIENTSECRET: <BITWARDEN CLIENT SECRET>
```
