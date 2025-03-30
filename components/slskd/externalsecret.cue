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
					BETANIN_API_KEY:     "{{ .BETANIN_API_KEY}}"
					SLSKD_SLSK_USERNAME: "{{ .SLSKD_SLSK_USERNAME }}"
					SLSKD_SLSK_PASSWORD: "{{ .SLSKD_SLSK_PASSWORD }}"
				}
			}
			data: [
				{secretKey: "BETANIN_API_KEY", remoteRef: {key: "BETANIN_API_KEY"}},
				{secretKey: "SLSKD_SLSK_USERNAME", remoteRef: {key: "SLSKD_SLSK_USERNAME"}},
				{secretKey: "SLSKD_SLSK_PASSWORD", remoteRef: {key: "SLSKD_SLSK_PASSWORD"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
