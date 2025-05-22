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
					MUMBLE_SUPERUSER_PASSWORD: "{{ .MUMBLE_SUPERUSER_PASSWORD }}"
				}
			}
			data: [
				{secretKey: "MUMBLE_SUPERUSER_PASSWORD", remoteRef: {key: "MUMBLE_SUPERUSER_PASSWORD"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
