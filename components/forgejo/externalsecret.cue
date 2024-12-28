package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: "gitea-admin"
			target: template: {
				engineVersion: "v2"
				data: {
					username: "{{ .GITEA_USER }}"
					password: "{{ .GITEA_PASS }}"
					email:    "{{ .GITEA_EMAIL }}"
				}
			}
			data: [
				{secretKey: "GITEA_USER", remoteRef: {key: "GITEA_USER"}},
				{secretKey: "GITEA_PASS", remoteRef: {key: "GITEA_PASS"}},
				{secretKey: "GITEA_EMAIL", remoteRef: {key: "GITEA_EMAIL"}},
			]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
