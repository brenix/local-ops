package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "cloudflared-tunnel": {
		metadata: name:      "cloudflared-tunnel"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: "credentials.json": """
					{
					  "AccountTag": "{{ .ACCOUNT_TAG }}",
					  "TunnelSecret": "{{ .TUNNEL_SECRET }}",
					  "TunnelID": "7f90e49b-765b-4de7-854a-70e3d3d1e5eb"
					}
					"""
			}
			dataFrom: [{extract: key: "cloudflare"}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
