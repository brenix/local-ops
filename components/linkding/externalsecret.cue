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
					LD_SUPERUSER_NAME:     "{{ .username }}"
					LD_SUPERUSER_PASSWORD: "{{ .password }}"
				}
			}
			dataFrom: [{extract: key: Name}]
			secretStoreRef: kind: "ClusterSecretStore"
			secretStoreRef: name: "onepassword-connect"
		}
	}
}
