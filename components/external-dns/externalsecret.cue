package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: "external-dns-cloudflare": {
		metadata: name:      "external-dns-cloudflare"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					CF_API_EMAIL: "{{ .CLOUDFLARE_API_EMAIL }}"
					CF_API_KEY:   "{{ .CLOUDFLARE_API_KEY }}"
				}
			}
			data: [
				{secretKey: "CLOUDFLARE_API_EMAIL", remoteRef: {key: "CLOUDFLARE_API_EMAIL"}},
				{secretKey: "CLOUDFLARE_API_KEY", remoteRef: {key: "CLOUDFLARE_API_KEY"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
