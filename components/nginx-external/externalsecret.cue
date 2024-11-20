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
			dataFrom: [{extract: key: "maxmind"}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
