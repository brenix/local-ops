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
			dataFrom: [
				{extract: key: "radarr"},
				{extract: key: "sonarr"},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
