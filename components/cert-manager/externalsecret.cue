package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      "cloudflare"
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: data: CLOUDFLARE_API_KEY: "{{ .CLOUDFLARE_API_KEY }}"
			data: [{secretKey: "CLOUDFLARE_API_KEY", remoteRef: {key: "CLOUDFLARE_API_KEY"}}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
