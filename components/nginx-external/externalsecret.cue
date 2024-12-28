package holos

Component: {
	Name:      string
	Namespace: string

	Resources: ExternalSecret: (Name): {
		metadata: name:      Name
		metadata: namespace: Namespace
		spec: {
			target: name: "nginx-external-maxmind-secret"
			target: template: {
				engineVersion: "v2"
				data: MAXMIND_LICENSE_KEY: "{{ .MAXMIND_API_KEY }}"
			}
			data: [{secretKey: "MAXMIND_API_KEY", remoteRef: {key: "MAXMIND_API_KEY"}}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "doppler"
		}
	}
}
