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
					"config.toml": """
						[frontend]
						username = "{{ .BETANIN_USERNAME }}"
						password = "{{ .BETANIN_PASSWORD }}"
						[clients]
						api_key = "{{ .BETANIN_API_KEY }}"
						[server]
						num_parallel_jobs = 1
						[notifications.services]
						[notifications.strings]
						title = "Music Imported"
						body = "$name"
						"""
				}
			}
			data: [
				{secretKey: "BETANIN_API_KEY", remoteRef: {key: "BETANIN_API_KEY"}},
				{secretKey: "BETANIN_USERNAME", remoteRef: {key: "BETANIN_USERNAME"}},
				{secretKey: "BETANIN_PASSWORD", remoteRef: {key: "BETANIN_PASSWORD"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
