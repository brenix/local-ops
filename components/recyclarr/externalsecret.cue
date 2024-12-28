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
					RADARR_API_KEY: "{{ .RADARR_API_KEY }}"
					SONARR_API_KEY: "{{ .SONARR_API_KEY }}"
				}
			}
			data: [
				{secretKey: "RADARR_API_KEY", remoteRef: {key: "RADARR_API_KEY"}},
				{secretKey: "SONARR_API_KEY", remoteRef: {key: "SONARR_API_KEY"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
