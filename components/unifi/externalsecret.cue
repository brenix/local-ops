package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: Name
			target: template: {
				engineVersion: "v2"
				data: {
					MONGO_USER: "{{ .MONGODB_USER }}"
					MONGO_PASS: "{{ .MONGODB_PASS }}"
				}
			}
			data: [
				{secretKey: "MONGODB_USER", remoteRef: {key: "MONGODB_USER"}},
				{secretKey: "MONGODB_PASS", remoteRef: {key: "MONGODB_PASS"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
