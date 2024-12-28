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
					  "AccountTag": "{{ .CLOUDFLARE_ACCOUNT_TAG }}",
					  "TunnelSecret": "{{ .CLOUDFLARE_TUNNEL_SECRET }}",
					  "TunnelID": "7f90e49b-765b-4de7-854a-70e3d3d1e5eb"
					}
					"""
			}
			data: [
				{secretKey: "CLOUDFLARE_ACCOUNT_TAG", remoteRef: {key: "CLOUDFLARE_ACCOUNT_TAG"}},
				{secretKey: "CLOUDFLARE_TUNNEL_SECRET", remoteRef: {key: "CLOUDFLARE_TUNNEL_SECRET"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
