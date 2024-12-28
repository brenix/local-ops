package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: metadata.name
			target: template: {
				engineVersion: "v2"
				data: {
					LD_SUPERUSER_NAME:     "{{ .LINKDING_USER }}"
					LD_SUPERUSER_PASSWORD: "{{ .LINKDING_PASS }}"
				}
			}
			data: [
				{secretKey: "LINKDING_USER", remoteRef: {key: "LINKDING_USER"}},
				{secretKey: "LINKDING_PASS", remoteRef: {key: "LINKDING_PASS"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
