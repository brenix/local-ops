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
			dataFrom: [{extract: key: metadata.name}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
